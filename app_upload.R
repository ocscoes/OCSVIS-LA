#********************************
#Upload app *********************
#********************************

# install.packages('rsconnect')
# install.packages('here')
# install.packages("tictoc") #timming de funciones


library(rsconnect)
library(here)
here()





# Realizar el login de la cuenta y el token de acceso  --------------------

rsconnect::setAccountInfo(name='juitsa', #account
                          token='4E3E38F216E2433D6290D64905056C90',
                          secret='lVM2gyMtbp/0pMKlsQ77FiCbXFy/gXzlGUq60apt')


tictoc::tic() #inicio...
rsconnect::deployApp() #Subir App al server de shinyapps
Y # Dar el YES
tictoc::toc() #término...

rsconnect::terminateApp(appName = "lapop_iturra-observatorio_cohesion")
