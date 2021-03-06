//+------------------------------------------------------------------+
//|                                            EA_MT5_Telegram_3.mq5 |
//|                                Rafaelfvcs 2021, Analistas Quant. |
//|                        https://crieseurobocommql5.wordpress.com/ |
//+------------------------------------------------------------------+
#property copyright "Rafaelfvcs 2021, Analistas Quant."
#property link      "https://crieseurobocommql5.wordpress.com/"
#property version   "1.00"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input string Token = "161912345:BBEsMeWzoBwn43NSDF4SZemaT6Pyw4lA2-B"; // Token Telegram

//---
#include <Telegram.mqh>
#include <Trade/Trade.mqh>

//---
CTrade            trade; //  Clase para envio e manipulações de Ordens e posições

//---
//CCustomBot bot;
class CMyBot: public CCustomBot
  {

private:
  
public:
   //+------------------------------------------------------------------+       
   

   void ProcessMessages(void)
     {
      
      for(int i=0;i<m_chats.Total();i++)
        {
         CCustomChat *chat=m_chats.GetNodeAtIndex(i);
         if(!chat.m_new_one.done)
           {
            chat.m_new_one.done=true;
            string text=chat.m_new_one.message_text;
            
            if(text =="/start" || text =="/help")
              {
               bot.SendMessage(chat.m_id,"Olá, seja bem vindo(a) ao robô Mt5 Telegram");
              }
            

            if( text == "/comprar" )
              {
               // Fazer compra
              }
            if(text == "/vender")
              {
               // Fazer venda
              }
            if(text == "/fechar") 
              {
               // Fechar posição
              } 
               
           }
        }
     
     }

  };


CMyBot bot;
int getme_result;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(1); // Requisitar a função OnTimer de 1 em 1 segundo!
   
   bot.Token(Token); // Conectar Token com a API do Telegram
   
   getme_result = bot.GetMe(); // Fazer primeiro contato com o bot do telegram
   
   Print("Funcionou a conexão = ", getme_result); // se getme_result = 0 (zero), deu tudo certo
   Print("Nome do robô: ",bot.Name() ); // Retorna nome do Robô
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
