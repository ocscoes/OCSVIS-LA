#********************************
#Upload app *********************
#********************************

#Este archivo sirve principalmente para generar el deploy de la app en el servidor de shiny.apps


# install.packages('rsconnect')
# install.packages('here')
# install.packages("tictoc") #timming de funciones


library(rsconnect)
library(here)


# Realizar el login de la cuenta y el token de acceso  --------------------

rsconnect::setAccountInfo(name='juitsa', #account
                          token='4E3E38F216E2433D6290D64905056C90',
                          secret='lVM2gyMtbp/0pMKlsQ77FiCbXFy/gXzlGUq60apt')


tictoc::tic() #inicio...
rsconnect::deployApp(forceUpdate = TRUE) #Subir App al server de shinyapps
 
tictoc::toc() #término...

rsconnect::terminateApp(appName = "ocs-coes")
