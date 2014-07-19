//+------------------------------------------------------------------+
//|                                                   web_client.mq4 |
//|                                    Copyright 2014, samuraitaiga. |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, samuraitaiga."
#property version   "1.00"
#property strict
extern bool save_local = true;
extern bool print_http_result = true;
//--- for working with server you need to add "https://www.google.com/finance" 
//--- to the list of the allowed URLs (Main menu->Tools->Options, "Expert Advisors" tab)
extern string url="http://www.myfxbook.com/streaming-forex-news";
extern string stored_html_name = "web_client.html";

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   string cookie=NULL,headers;
   char post[],result[];
   int res;
//--- reset last error
   ResetLastError();
//--- load html page from Google Finance
   res=WebRequest("GET",
                  url,
                  cookie,
                  NULL,
                  50,
                  post,
                  0,
                  result,
                  headers);
//--- check errors
   if(res==-1)
     {
      Print("Error code =",GetLastError());
      //--- maybe the URL is not added, show message to add it
      MessageBox("Add address '"+url+"' in Expert Advisors tab of the Options window","Error",MB_ICONINFORMATION);
     }
   else
     {
      //--- successful
      PrintFormat("Download successful, size =%d bytes.",ArraySize(result));
      //--- save data to file
      if(save_local == true){
         int filehandle=FileOpen(stored_html_name ,FILE_WRITE|FILE_BIN);
         //--- check
         if(filehandle!=INVALID_HANDLE)
           {
            //--- write result[] array to file
            FileWriteArray(filehandle,result,0,ArraySize(result));
            //--- close file
            FileClose(filehandle);
           }
         else Print("Error in FileOpen. Error code=",GetLastError());
       }
       if(print_http_result == true){
         int filehandle=FileOpen(stored_html_name ,FILE_READ|FILE_BIN|FILE_ANSI);
         if(filehandle!=INVALID_HANDLE)
         {
            int str_size=FileReadInteger(filehandle,INT_VALUE);
            PrintFormat("str_size = %d", str_size);
            string str=FileReadString(filehandle,40000);
            PrintFormat(str);
            FileClose(filehandle);
         }
       }
     }
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
