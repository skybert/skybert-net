title: User Manager SSO Behind the Scenes
date: 2019-08-27
category: escenic
tags: escenic, sso, gluu

> I want to log into CUE using a user that only exists on my IAM
> backend

Before we start, here's a rough sketch of our architecture:

<a href="/graphics/2019/um-deep-dive/0001.svg">
  <img src="/graphics/2019/um-deep-dive/0001.svg"
       alt="UM architecture"
       width="1024px"
       class="centered"
   />
</a>

CUE Content store has two publications:

- `one`
- `two`

Our IAM backend here is Gluu:

<a href="/graphics/2019/um-deep-dive/001.png">
  <img src="/graphics/2019/um-deep-dive/001.png"
       alt="gluu"
       width="1024px"
       class="centered"
   />
</a>

and we have a user called `john`:

<a href="/graphics/2019/um-deep-dive/002.png">
  <img src="/graphics/2019/um-deep-dive/002.png"
       alt="gluu user creation"
       width="1024px"
       class="centered"
   />
</a>

We can query the UM REST interface to see `john`, e.g.:
```text
http://um.example.com/user/username/john
```

<a href="/graphics/2019/um-deep-dive/003.png">
  <img src="/graphics/2019/um-deep-dive/003.png"
       alt="gluu user through um"
       width="1024px"
       class="centered"
   />
</a>

The bare basics are there, but as you can see, there are no `groups`.

In Gluu, we now define groups, one for each publication we want the user
to log into:

- `one_editor`
- `two_journalist`

We add our Gluu only user `john` to these two groups:

<a href="/graphics/2019/um-deep-dive/004.png">
  <img src="/graphics/2019/um-deep-dive/004.png"
       alt="gluu user through um"
       width="1024px"
       class="centered"
   />
</a>

You can now see that the groups are available in the User Manager web
service: `http://um.example.com/user/username/john`.

<a href="/graphics/2019/um-deep-dive/006.png">
  <img src="/graphics/2019/um-deep-dive/006.png"
       alt="gluu user through um"
       width="1024px"
       class="centered"
   />
</a>

As you see, UM has figured out which publications and roles to assign
to the user on the ECE side of the equation. Pretty sweet, eh? It does
this by looking up `provider.newsroom.template` and
`provider.newsroom.roleMapping` in
`/etc/escenic/user-manager/user-manager.yaml`, more on this later.

## Check that there's no john user in CUE Content Store
<a href="/graphics/2019/um-deep-dive/007.png">
  <img src="/graphics/2019/um-deep-dive/007.png"
       alt="gluu user through um"
       width="1024px"
       class="centered"
   />
</a>

## Log into CUE using UM

When logging into CUE, we select to use UM rather than regular
login (just click the link):

<a href="/graphics/2019/um-deep-dive/008.png">
  <img src="/graphics/2019/um-deep-dive/008.png"
       alt="gluu user through um"
       width="1024px"
       class="centered"
   />
</a>


If you see no link, you need to enable the Nusery component
`/com/escenic/auth/um/UMConfiguration`.

## ECE redirects you to UM which in turn redirects you to the IAM backend
The IAM backend will then handle the log in, applying whatever two
factor or multi factor auth you've set up. For our example here, it
does a regular Gluu user authentication:

<a href="/graphics/2019/um-deep-dive/009.png">
  <img src="/graphics/2019/um-deep-dive/009.png"
       alt="gluu login"
       width="1024px"
       class="centered"
   />
</a>

The first time `john` authenticates against the IAM backend (the OIDC
endpoint to be precise), he'll be asked to grant a set of
permissions. This is similar to what other sites ask you when you log
on to their site using your Google or Facebook login:

<a href="/graphics/2019/um-deep-dive/010.png">
  <img src="/graphics/2019/um-deep-dive/010.png"
       alt="oidc permissions"
       width="1024px"
       class="centered"
   />
</a>

## IAM passed control back to ECE
Once the user is logged in, the IAM passes control back to ECE which
now queries UM for what to do with the user `john`.

One of the things ECE does, is to ask UM for user information, the
list of ECE groups and ECE roles and to which publications they're to
be added. It does this be querying the resource:
```text
http://um.example.com/user/me
```

## UM prepares user info for ECE to use
It accomplishes this by matching the **publication** name and
**group** names from the template in
`/etc/escenic/user-manager/user-manager.yaml`:

```yaml
provider:
  newsroom:
    template: ${publication}_${name}
    roleMapping:
      journalist:
        - journalist
        - reader
        - articleWithContentTypeWriter
        - articleWithContentTypeReader
      editor:
        - editor
        - journalist
        - reader
        - articleWithContentTypeWriter
        - articleWithContentTypeReader
```

If you go back to where we created the groups in Gluu, we chose names
like `one_editor`.  With the above configuration,
this means publication will be `one` and (group) `name` will be
`editor`. The group `editor` is defined in `roleMapping` to imply
the ECE roles (as in ECE's `roles.xml`) `editor`, `journalist`,
`reader`, `articleWithContentTypeReader`
`articleWithContentTypeWriter`.

The default `user-manager.yaml` comes with more mappings you'll likely
want to use.

This wiring ensures that when ECE calls
`http://um.example.com/user/username/john` (or `/user/me` if `john` is
the current user), the following UM groups are returned:

```json
    "groups": [
      {
        "roles": [
          "editor",
          "journalist",
          "reader",
          "articleWithContentTypeWriter",
          "articleWithContentTypeReader"
        ],
        "publicationNames": [
          "one"
        ],
        "users": [],
        "externalId": "@!115E.DBC0.9B17.9235!0001!6F22.9DDB!0003!A52F.A11C",
        "ids": [],
        "displayName": "editor",
        "uniqueName": "one_editor"
      },
      {
        "roles": [
          "journalist",
          "reader",
          "articleWithContentTypeWriter",
          "articleWithContentTypeReader"
        ],
        "publicationNames": [
          "two"
        ],
        "users": [],
        "externalId": "@!115E.DBC0.9B17.9235!0001!6F22.9DDB!0003!970A.1BF7",
        "ids": [],
        "displayName": "journalist",
        "uniqueName": "two_journalist"
      }
    ]
```

The `externalId` is the `inum` identifier in the Gluu LDAP backend. We
can use it to do reverse lookup using the UM API, or just to make
debugging easier.


## UM sends the user info back to ECE
ECE uses the information provided by UM to create:

- ECE groups (we've asked it to create two groups called `editor` and
  `journalist`) in correct publication(s).
- Assign a set of ECE roles to each of the groups
- Assign `john` to the groups created.

ECE will create groups inside of ECE corresponding to the user groups
we set in Gluu:

```sql
select
  re.publicationID,
  p.publicationName,
  re.genericName
from
  ReferenceEntity re,
  Publication p
where
  re.codeID=2
  and re.publicationID = p.referenceID;
+---------------+-----------------+-------------+
| publicationID | publicationName | genericName |
+---------------+-----------------+-------------+
|             1 | one             | editor      |
|             2 | two             | journalist  |
+---------------+-----------------+-------------+
```

It also creates a user `john` in the CUE Content Store database:

```sql
select * from Person p where p.username='john';
+----------+----------+-----------------------------------------+
| personID | username | attributes                              |
+----------+----------+-----------------------------------------+
|        7 | john     | {"first-name":"John","last-name":"Doe"} |
+----------+----------+-----------------------------------------+
```
If `john` has updated his user info in the IAM backend (or even in the
AD backend that the IAM systems syncs data from), ECE will query UM
for any updates and apply these accordingly in the ECE database.

ECE will then add `john` to the two newly created user groups:
```sql
select
  re.genericName,
  re.publicationID,
  gm.memberID
from
  GroupMember gm,
  ReferenceEntity re
where
  re.referenceID = gm.groupId
  and gm.memberID=7;
+-------------+---------------+----------+
| genericName | publicationID | memberID |
+-------------+---------------+----------+
| editor      |             1 |        7 |
| journalist  |             2 |        7 |
+-------------+---------------+----------+
```

As with the user information, if the group memberships of `john` has
changed in the IAM backend, these will be applied by ECE.

## In case you don't want any magic

The ECE component, `com/escenic/auth/um/UMConfiguration` that does all
the magic of creating users and groups, can be told to turn off parts
of or all the magic by setting:
```conf
autoCreateUser=false
autoCreateGroup=false
autoUpdateUser=false
updateGroupOfUser=false
```

These can be turn off and on at your own will. The user info and
credentials are all in the domain of the IAM backend. If you turn
off these or parts of them, you can turn them back on at any time
without problem.

## John is home free

Our Gluu only user `john` can now log into CUE and enjoy all the
privileges of a regular Content Store user. His user details and
password are maintained in the IAM backend:

<a href="/graphics/2019/um-deep-dive/011.png">
  <img src="/graphics/2019/um-deep-dive/011.png"
       alt="gluu user logged into cue"
       width="1024px"
       class="centered"
   />
</a>

`john` can create content and get his due credits in the **Authors**
box:

<a href="/graphics/2019/um-deep-dive/012.png">
  <img src="/graphics/2019/um-deep-dive/012.png"
       alt="gluu user logged into cue, creates content"
       width="1024px"
       class="centered"
   />
</a>

## Authorisation by org unit

Instead of providing mapping like `<publication>_<group_name>` you can
also do `<org-unit>_<group_name>` (a `newsroom` is the same thing as
an org/organizational unit)

```yaml
provider:
  newsroom:
    template: ${newsroom}_${name}

    publicationMapping:
      sports:
        - football
        - trailrunning
      life:
        - fashion
        - food
        - travel
```

Now, if we create a new user `lisa` and assign her to the groups
`life_editor` and `sports_journalist`, UM generates the list of
publications and roles for her.

The UM resource for `lisa`:
```text
http://um.example.com/user/username/lisa
```

now returns:
```json
[
  {
    "createdAt": 1566911790054.0,
    "updatedAt": 1566911860892.0,
    "externalId": "@!115E.DBC0.9B17.9235!0001!6F22.9DDB!0000!8032.2C22.2729.51B6",
    "familyName": "Donna",
    "givenName": "Lisa",
    "userName": "lisa",
    "homePublication": "football",
    "groups": [
      {
        "uniqueName": "sports_journalist",
        "displayName": "journalist",
        "ids": [],
        "externalId": "@!115E.DBC0.9B17.9235!0001!6F22.9DDB!0003!A880.8C14",
        "users": [],
        "publicationNames": [
          "football",
          "trailrunning"
        ],
        "roles": [
          "journalist",
          "reader",
          "articleWithContentTypeWriter",
          "articleWithContentTypeReader"
        ]
      },
      {
        "uniqueName": "life_editor",
        "displayName": "editor",
        "ids": [],
        "externalId": "@!115E.DBC0.9B17.9235!0001!6F22.9DDB!0003!9305.49F8",
        "users": [],
        "publicationNames": [
          "fashion",
          "food",
          "travel"
        ],
        "roles": [
          "editor",
          "journalist",
          "reader",
          "articleWithContentTypeWriter",
          "articleWithContentTypeReader"
        ]
      }
    ]
  }
]
```


This means she should get the `editor` and `journalist` groups (and
through `roleMapping`, the corresponding roles) in all the
publications under each of the org units when she logs into CUE. And
lo and behold, that's exactly what happened after `lisa` logged into
CUE for the first time!

```sql
select
  pe.username,
  p.publicationName,
  re.genericName,
  re.referenceID
from
  Person pe,
  Publication p,
  GroupMember gm,
  ReferenceEntity re
where
  memberID=(select personID from Person where username='lisa')
  and gm.groupID=re.referenceID
  and p.referenceID=re.publicationID
  and gm.memberID=pe.personID
;

+----------+-----------------+-------------+-------------+
| username | publicationName | genericName | referenceID |
+----------+-----------------+-------------+-------------+
| lisa     | football        | journalist  |          20 |
| lisa     | trailrunning    | journalist  |          21 |
| lisa     | fashion         | editor      |          22 |
| lisa     | food            | editor      |          23 |
| lisa     | travel          | editor      |          24 |
+----------+-----------------+-------------+-------------+
```

The `referenceID`s here are the ids of the user _group_. To look up
what this means in practice, as ECE user groups are mere containers
and don't enforce things directly, we must use this id to look the
assigned rights through the following tables.

Let's find out which _roles_ the `editor` _group_ implies (that's the
one with `referenceID` `24` above):

```sql
select
  r.roleName,
  pd.uri,
  pd.publicationID
from
  Role r,
  ProtectionDomain pd,
  AccessControlList acl
where
  acl.referenceID=24
  and acl.protectionDomainID=pd.protectionDomainID
  and r.roleID=acl.roleID
;
+------------------------------+-------------------------+---------------+
| roleName                     | uri                     | publicationID |
+------------------------------+-------------------------+---------------+
| reader                       | internal:/publication/5 |             5 |
| editor                       | internal:/publication/5 |             5 |
| journalist                   | internal:/publication/5 |             5 |
| articleWithContentTypeReader | content-type:5          |             5 |
| articleWithContentTypeWriter | content-type:5          |             5 |
+------------------------------+-------------------------+---------------+
```

And surely, that's the exact list that we had defined in
`user-manager.yaml`. Excellent!

## Syncing from AD or another backend

The IAM system will typically get its user data from AD or another
LDAP server. If possible, sync the user groups from AD.

This means that, the `john` and `lisa` users above should belong to AD
groups called `one_editor`, `life_journalist` and so on.

Alternatively, UM can create the IAM groups and assign the IAM users
to these for you. This is necessary when syncing from AD to Gluu as
Gluu only supports syncing the user information. This is where the
`userGroups` array field on the IAM LDAP user object comes in.

This field is an extension to the SCIM schema, see the [User Manager
documentation](http://cuedocs.escenic.com/user-manager-guide/1.0/ad_sync.html). The
AD sync must be set up so that the AD user's `memberOf` array field is
synced to the IAM user's `userGroups` field. These will result in a
list of strings that may look like this (they must start with `CN=`):

```text
CN=sports,DC=foo,DC=bar
CN=life,DC=foo,DC=bar
```
For UM to populate the groups in the IAM backend, you must set:

```yaml
provider:
  groupSync:
    enabled: true
    interval: 5      # run every 5 minutes
```

UM will then periodically look up the `userGroups` field on the IAM
user and resolve that to a group in the IAM backend, adding or
removing the user to that group in accordance with the `userGroups`
field.

The above list of AD groups will result in:

- sports
- groups

The `,DC=foo,DC=bar` will be ignored by UM. UM will thus first check
the `sports` and `fashion`  groups exist in the IAM backend. If they
don't, UM will first create these (using the SCIM interface) and then
add the user to these groups. 
