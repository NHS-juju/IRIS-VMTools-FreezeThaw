# IRIS-VMTools-FreezeThaw
Script for enabling the use of a VM-level snapshot of a server running Intersystems IRIS on a Windows Server which is running under VMWare.

Submit bug reports and feature suggestions under the [issues tab](https://github.com/NHS-juju/CustomObjectScriptFunctions/issues) in github.

## Installation
Batch file must be placed in `C:\Program Files\VMware\VMware Tools\backupScripts.d\` (`backupScripts.d` may need to be created if not already present. [OS Based Authentication](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GAUTHN_OSBASED) must also be enabled.

## Health Warning
Part of the script will call `##Class(Backup.General).ExternalSetHistory()` which exists to set the backup history following an external backup. However, in environments where [Journaling](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GCDI_journal) is in use, running of this batch file without running actual backups (e.g. for testing) can and will trigger the deletion of journal files should you run the batch file a greater number of times than the setting  `After this many successive successful backups` for your [journal retention.](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GCDI_journal_config#GCDI_journal_config_settings)

## FAQ

**Q: Why does this exist?**

**A:** When relying on backups being taken at a VM-Level, it is important for the database to be momentarily paused for data integrity. As an [external backup ](https://docs.intersystems.com/supplychainlatest/csp/docbook/DocBook.UI.Page.cls?KEY=GCDI_backup#GCDI_backup_methods_ext) is considered the recommended best practice for backups, this script (or one similar) must be used to instruct IRIS to pause (or `freeze`) for the backup before resuming (or `thaw`) once complete.

**Q: This script feels familiar?**

**A:** I posted this script onto the [Intersystems Developer Community](https://community.intersystems.com/post/backup-freezethaw-batch-script-pitfalls-vmware-and-solutions) as an Article a few years ago along with outlining some obstacles faced getting this written and working.
