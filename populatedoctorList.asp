
 <%
                            Dim query
                            data = Request.QueryString("value")
                            response.write data

                            set conn=Server.CreateObject("ADODB.Connection")
                            conn.Provider="Microsoft.Jet.OLEDB.4.0"
                            conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"
                    
                            set rs=Server.CreateObject("ADODB.recordset")

                            if(data <>"") Then 
                                query="Select * FROM Doctor Where Specialization='"&data&"'"
                            Else
                                rs.Open "Select * FROM Doctor", conn
                            End If
                            respond.write rs.Filds
                            rs.Close
                            conn.Close                   
                       %>