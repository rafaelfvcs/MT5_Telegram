//+------------------------------------------------------------------+
//|                                            EA_MT5_Telegram_1.mq5 |
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
               bot.SendMessage(chat.m_id,"Olá, seja bem vindo(a) ao robô MT5 Telegram");
              }
            
           
            
            
            if( text == "/comprar" )// /comprar 50 50 10
              {
                Print("Vai tentar uma compra");
                if( !PositionSelect(_Symbol) )
                  {
                      compraMercado(0,0,0.1);
                      bot.SendMessage(chat.m_id,"Robô tentou comprar");
                  }
              }
            if(text == "/vender")
              {
                Print("Vai tentar uma venda");
                if( !PositionSelect(_Symbol) )
                  {
                      vendaMercado(0,0,0.1);
                      bot.SendMessage(chat.m_id,"Robô tentou vender");
                  }
              }
            if(text == "/fechar") // Fechar posição
              {
                  Print("Vai tentar fechar");
                  if( PositionSelect(_Symbol) )
                    {
                       fechaPosicao(PositionGetTicket(0));
                       bot.SendMessage(chat.m_id,"Robô tentou fechar");
                    }
              } 
               
               
               
            
           }
        }
     
     }
  
  
  };
//---
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
    if( getme_result != 0 ) // se diferente de zero é pq tivermos um erro!
     {
      Comment("Erro: ", GetErrorDescription(getme_result) );
      return;
     }else
        {
           bot.GetUpdates(); // coleta atualizações feitas no robô do Telegram
           
           bot.ProcessMessages(); // Rastrei comandos digitados pelos usuáriso do bot Telegram
        }
      
      
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void compraMercado(double tk, double sl, double num_lots = 20)
   {
        trade.Buy(num_lots,_Symbol,0,sl,tk);
                          
        if(trade.ResultRetcode() == 10008 || trade.ResultRetcode() == 10009)
          {
           Print("==> ORDEM DE COMPRA EXECUTADA COM SUCESSO !!");
          }
        else
          {
           Print("Erro ao EXECUTAR Ordem de Compra a mercado. Erro = ", GetLastError());
           ResetLastError();
          }
   }
//---
void vendaMercado(double tk, double sl, double num_lots = 20)
   {
        
        trade.Sell(num_lots,_Symbol,0,sl,tk);
                               
        if(trade.ResultRetcode() == 10008 || trade.ResultRetcode() == 10009)
          {
           Print("==> ORDEM DE VENDA EXECUTADA COM SUCESSO !!");
          }
        else
          {
           Print("Erro ao EXECUTAR Ordem de Venda a mercado. Erro = ", GetLastError());
           ResetLastError();
          }
   }   
//---
void fechaPosicao(ulong position_ticket)
   {
          
       Print("Fechamento da posicao : ", position_ticket);
       trade.PositionClose(position_ticket); 
       if(trade.ResultRetcode() == 10009) // 10009 TRADE_RETCODE_DONE - Solicitação concluída
          {
           Print("==> ORDEM FECHADA COM SUCESSO !!");
          }
         else
          {
           Print("Erro ao FECHADA Ordem. Erro = ", GetLastError());
           ResetLastError();
          }

   
   }