#Upload app


# install.packages('rsconnect')
# install.packages('here')


library(rsconnect)
library(here)
here()


rsconnect::setAccountInfo(name='juitsa',
                          token='4E3E38F216E2433D6290D64905056C90',
                          secret='lVM2gyMtbp/0pMKlsQ77FiCbXFy/gXzlGUq60apt')


tictoc::tic()
rsconnect::deployApp()
Y
tictoc::toc()

rsconnect::terminateApp(appName = "lapop_iturra-observatorio_cohesion")
