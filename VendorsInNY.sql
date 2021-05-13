select * /* select all*/
from AP.dbo.Vendors /* chooses AP database, then chooses Vendors table*/
where VendorState = 'NY' /* searches the VendorState column for any instances of NY and returns */
