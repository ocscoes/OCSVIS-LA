install.packages('rsconnect')

rsconnect::setAccountInfo(name='gabrielcortesp', token='8ED1A66A016F143C75BD71D230D3C0A2', secret='sQ0pJkQZepkHpzWbjLM/d3oVh9QDN2r1wET6ry+l')

library(rsconnect)
rsconnect::deployApp('.')
