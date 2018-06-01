title: CUE User Manager
date: 2018-05-24
category: escenic
tags: escenic, cue

> On a fresh system, without AD sync, can I create a new user in Gluu
> and have that successfully log into ECE/CUE?

Yes, as long as the Gluu user has the custom fields `homePublication`
and `groups` set.

> If we've forgotten to set homePublication and/or userGroups on the
> gluu::person and the user has been created in ECE, will the new
> homePublication and userGroups fields get synced or is the ECE users
> left to their own devices?

- If you don't set home publication, the user won't be created.
- If you add/remove groups later, they will be synced after the caches
  are expired.
- If you add group to role mapping later, they will be synced
  too. 

> Does this mean we must provide a default `publicationMapping` too?
> Or will it work as long as the gluu:userGroups contain fields like
> `anything_editor`? 

If the newroom template is `${ignore}_${name}`, `anything_editor` will
map to group with name `editor` in ECE.  If you don't provide
`publicationMapping`, you will have to set `homePublcation`. (edited)
