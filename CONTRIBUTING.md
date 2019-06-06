# Contributing to Neural::Net

Neural::Net is open source and contributions are more than welcome. Bug reports,
feature requests, code contributions, and documentation improvements are all
highly appreciated.

## Bug reports and feature requests

Make sure you are using the latest version of Neural::Net. If the issue hasn't
been addressed yet and a GitHub issue hasn't been raised, feel free to open one.

For bug reports, please try to golf your code to a minimal example, keeping it 
as generic as possible. Some problems may require a little more verbosity, but
clear code will help pinpoint the cause.
If the bug is caused by a regression, it will help if you could do a git bisect.
If that is difficult, feel free to ask for help.

For feature requests, please keep in mind that this module is not meant to be a
fully featured ML framework, just a simple neural network. If you want a lot
more functionality, it might be of interest to incorporate this module into a
larger project.

## Contributing code or documentation changes

Please find or open an issue about the changes you are making first, this will 
help prevent duplication of effort and make it possible to coordinate work.

If you are unsure of where to begin working on something, or of how to get your
changes in shape for inclusion in the project, feel free to ask.

## Working on Neural::Net

Starting with the full 1.0 release, Neural::Net will be worked on using
[git flow](https://nvie.com/posts/a-successful-git-branching-model/).

* Fork off from the `dev` branch to a branch with the ID of the pull request
(e.g. `1-documentation`).
* Write your code/docs, committing each major change seperately.
* Test your changes and make sure the docs are up-to-date.
* Push your branch to your own fork on GitHub.
* Open a pull request to the `dev` branch on the main Neural::Net repository.

For more information on how to keep your git activity clean, you can watch
[Logs Are Magic: Why Git Workflows and Commit Structure Should Matter To You](https://www.youtube.com/watch?v=n_WGiS8fm8s)
by John Anderson.

As soon as your changes have been looked at, and any kinks have been worked out
you will be given the opportunity to add your name to the author list in the 
README file, this is not a requirement, but having a contact point is always 
useful in case any regressions are discovered later on.
