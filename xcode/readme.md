Playground Xcode Projects
=========================

Xcode projects containing playgrounds. Allows playgrounds to use external libraries.

After checkout:

```
> cd somePlaygrounds
> pod install
> open Workspace.xcworkspace
```

**First build the main target**, before running any playground. Otherwise the playground will not find the external libraries.

