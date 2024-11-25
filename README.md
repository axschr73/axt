# axt
Axel's Tools (bash)

Don't forget to add axt directory to your $PATH

AXT needs the following helpers to work (please install before running AXT):
* peco - interactive less (https://github.com/peco/peco/releases)

Run axt setup after you've cloned AXT!


Commands:
  edit   - Edit an existing AXT command or file (see subcommands)
             * bash - Edit ~/.bashrc & re-source
             * csv  - Edit Basis::TestFrame CSV files with LibreOffice
  setup  - Setup AXT environment
  create - Create a new AXT command
  git    - AXT's git tools (use subcommands)
             * reset  - Reset local branch to current remote branch
             * commit - Stage & commit all changed files (incuding new & deleted)
             * remote - Switch to new remote branch (and use/create matching or user-defined local branch)
             * branch - Switch local branch
             * log    - peco'd git log viewer
             * amend  - Amend last commit with all changed files (including new/deleted)
             * rebase - Rebase local branch on current remote branch
  help   - Print this help text
  update - Update AXT or other components (see subcommands)
             * axt - Update AXT
