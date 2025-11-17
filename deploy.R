# install.packages("http://cran.r-project.org/src/contrib/Archive/curl/curl_6.2.3.tar.gz",
#                  repos = NULL, type = "source")


# Intenta reinstalar directamente (opción simple)
install.packages("rsconnect", repos = "https://cloud.r-project.org")


#install.packages("devtools")
library(pacman)
p_load(rsconnect,
       quarto)


      
#rsconnect::setAccountInfo(name='gabrielcortesp', token='8ED1A66A016F143C75BD71D230D3C0A2', 
                          #secret='sQ0pJkQZepkHpzWbjLM/d3oVh9QDN2r1wET6ry+l')

rsconnect::setAccountInfo(name='ocs-coes',
			  token='966FC8FD0EF43CB5B3EFB982C32530A7',
			  secret='gGXd5aw/yza5GHnyukmmeoMjicFUfeqWLgyP056c')

quarto::quarto_publish_app(input = "visualizador-la.qmd",
                   server="shinyapps.io",
                   name = "visualizador-la",
                   account = "ocs-coes")



