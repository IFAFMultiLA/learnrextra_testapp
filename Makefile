SERVER := htwserver-mk
APPDIR := ~/ShinyApps/adaptivelearnr_testapp
SERVER_APP := $(SERVER):$(APPDIR)
RSYNC_COMMON := -rcv --exclude-from=.rsyncexclude

devserver:
	-rm adaptivelearnr_test.html
	R -e 'renv::install("../adaptivelearnr");rmarkdown::run("adaptivelearnr_test.Rmd", shiny_args = list(port = 8001, launch.browser = FALSE))'

sync: deploymentfiles
	rsync $(RSYNC_COMMON) . $(SERVER_APP)
	ssh $(SERVER) 'cd $(APPDIR) && mv adaptivelearnr_test_prod.Rmd adaptivelearnr_test.Rmd'
	rm adaptivelearnr_test_prod.Rmd

testsync: deploymentfiles
	rsync $(RSYNC_COMMON) -n . $(SERVER_APP)
	rm adaptivelearnr_test_prod.Rmd

reload:
	ssh $(SERVER) 'touch $(APPDIR)/restart.txt'

installdeps:
	ssh $(SERVER) 'cd $(APPDIR) && R -e "renv::restore()"'

deploymentfiles:
	sed -- 's/apiserver: http:\/\/localhost:8000\//apiserver: https:\/\/rshiny.f4.htw-berlin.de\/api\//g' adaptivelearnr_test.Rmd > adaptivelearnr_test_prod.Rmd