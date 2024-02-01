SERVER := htwserver-mk
APPDIR := ~/ShinyApps/learnrextra_testapp
SERVER_APP := $(SERVER):$(APPDIR)
RSYNC_COMMON := -rcv --exclude-from=.rsyncexclude

devserver:
	-rm learnrextra_test.html
	R -e 'renv::install("../learnrextra");rmarkdown::run("learnrextra_test.Rmd", shiny_args = list(port = 8001, launch.browser = FALSE))'

sync: deploymentfiles
	rsync $(RSYNC_COMMON) . $(SERVER_APP)
	ssh $(SERVER) 'cd $(APPDIR) && mv learnrextra_test_prod.Rmd learnrextra_test.Rmd'
	rm learnrextra_test_prod.Rmd

testsync: deploymentfiles
	rsync $(RSYNC_COMMON) -n . $(SERVER_APP)
	rm learnrextra_test_prod.Rmd

reload:
	ssh $(SERVER) 'touch $(APPDIR)/restart.txt'

installdeps:
	ssh $(SERVER) 'cd $(APPDIR) && R -e "renv::restore()"'

deploymentfiles:
	sed -- 's/apiserver: http:\/\/localhost:8000\//apiserver: https:\/\/rshiny.f4.htw-berlin.de\/api\//g' learnrextra_test.Rmd > learnrextra_test_prod.Rmd