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
  hana   - AXT's HANA tools (use subcommands)
             * expected - Update HANA's public interface expected files
             * sync     - Sync local make/test directories with given instance>
             * test     - Run python test in the testscripts directory of the given instance (SID)
  mit    - Proxy for MakeInstallTest script
  hm     - AXT's HappyMake tools (use subcommands)
             * clean - Cleanup HappyMake's build & cache directories
             * init  - <add short help text (one line)>
  gerrit - AXT's gerrit tools (use subcommands)
             * push  - Push local branch to current remote branch
             * diff  - Show commit diff between current remote branch and orange (or other branch)
             * merge - Merge one branch to another via local branch
  setup  - Setup AXT environment
             * hm  - Setup HappyMake 
             * git - Setup HANA Core git repository
  create - Create a new AXT command
  git    - AXT's git tools (use subcommands)
             * reset  - Reset local branch to current remote branch
             * commit - Stage & commit all changed files (incuding new & deleted)
             * remote - Switch to new remote branch (and use/create matching or user-defined local branch)
             * branch - Switch local branch
             * log    - peco'd git log viewer
             * amend  - Amend last commit with all changed files (including new/deleted)
             * rebase - Rebase local branch on current remote branch
  sbt    - Execute tests registered with the Basis::TestFrame framework
             * all       - Execute all Basis/DataAccess tests registered with the Basis::TestFrame framework
             * pers      - Execute all tests registered for executable 'test_dataaccess'
             * clean     - Cleanup sbt directory
             * perslayer - Execute all tests registered for executable 'test_persistencelayer_da'
             * basis     - Execute all tests registered for executable 'test_basis'
  test   - Execute tests based on the Basis::TestFrame
             * pers  - Execute 'test_dataaccess'
             * basis - Execute 'test_basis'
  help   - Print this help text
  update - Update AXT or other components (see subcommands)
             * axt - Update AXT
