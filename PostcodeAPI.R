library(RJSONIO)
library(RCurl)

# Select data for conversion
Postcodes <- read.delim("D:/95_RAW_DATA_LIBRARY/www.postcodeapi.nu/PostcodeAPI/Postcodes.txt")



# Get Postcode
# SAMPLE: http://api.postcodeapi.nu/5041EB
# INPUT Datatype: Data.Frame
getPostcode <- function ( data ) {
  
  for (i in 1:nrow(data)) {
    url = paste('http://api.postcodeapi.nu/', data[i,3],sep='')
    
    result = getURL(url=url, 
                    verbose=FALSE,
                    httpheader=c('Api-Key' = '6b78c0a22cca8ec8f003daa626872ba7345bc4c0')) 
    
    
    result = as.data.frame(fromJSON(result))
  
    if ( i == 1 ) {
      final = result  
    } else {
      final = rbind(final, result)
    }
  
  }
  
  # output dataframe with results
  final
}
getPostcodeStraat <- function ( data ) {
  
  for (i in 1:nrow(data)) {
    url = paste('http://api.postcodeapi.nu/', data[i,3],'/',data[i,1] ,sep='')
    
    result = getURL(url=url, 
                    verbose=FALSE,
                    httpheader=c('Api-Key' = '6b78c0a22cca8ec8f003daa626872ba7345bc4c0')) 
    
    
    result = as.data.frame(fromJSON(result))
    

    if (result[1] == TRUE) {

      if ( i == 1 ) {
        final = result  
      } else {
        final = rbind(final, result)
      }      
      
    } else {
      print('lookup failed')
    }
    
  }
  
  # output dataframe with results
  final
}



# TEST Functions
output = getPostcodeStraat(Postcodes)
#getPostcode(Postcodes)
