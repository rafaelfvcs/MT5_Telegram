//+------------------------------------------------------------------+
//|                                            EA_MT5_Telegram_2.mq5 |
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


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
   
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
