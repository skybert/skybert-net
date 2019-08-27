title: User Manager SSO Behind the Scenes
date: 2019-08-27
category: escenic
tags: escenic, sso, gluu

> I want to log into CUE using a user that only exists on my IAM
> backend

CUE Content store has two publications:
- `one`
- `two`

In Gluu, we define groups, one for each publication we want the user
to log into:
- `one_editor`
- `two_journalist`

We add our Gluu only user `john` to these two groups.

You can now see that the groups are available in the User Manager web
service: `http://um.example.com/user/username/john`.

## Log into CUE using UM

When logging into CUE, we select to use UM rather than regular
login (just click on the link).

If you see no link, you need to enable the Nusery component
`/com/escenic/auth/um/UMConfiguration`.

## ECE redirects you to UM which in turn redirects you to the IAM backend
The IAM backend will then handle the log in, applying whatever two
factor or multi factor auth you've set up. For our example here, it
does a regular Gluu user authentication.

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
      reader:
        - reader
        - articleWithContentTypeReader
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
      admin:
        - publicationadmin
        - useradmin
        - administrator
        - editor
        - journalist
        - reader
        - articleWithContentTypeWriter
        - articleWithContentTypeReader
```

This ensures that when ECE calls
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
MariaDB [ecedb]> select re.publicationID, p.publicationName, re.genericName
  from ReferenceEntity re, Publication p
  where re.codeID=2 and re.publicationID = p.referenceID;
+---------------+-----------------+-------------+
| publicationID | publicationName | genericName |
+---------------+-----------------+-------------+
|             1 | one             | editor      |
|             2 | two             | journalist  |
+---------------+-----------------+-------------+
```

It also creates a user `john` in the CUE Content Store database:

```sql
MariaDB [ecedb]> select * from Person p where p.username='john';
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
```text

MariaDB [ecedb]> select re.genericName, re.publicationID, gm.memberID
  from GroupMember gm, ReferenceEntity re
  where re.referenceID = gm.groupId and gm.memberID=7;
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
password are maintained in the IAM backend.

