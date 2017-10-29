//+------------------------------------------------------------------+
//|                                                       orders.mqh |
//|                        Copyright 2014, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property strict
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+

   //--- Market Sessions Hours
   int Euro_Frankfurt_GMT_Start = 7;
   int Euro_Frankfurt_GMT_End   = 16;
   
   int Euro_London_GMT_Start    = 8;
   int Euro_London_GMT_End      = 17;
   
   int USA_NewYork_GMT_Start    = 13;
   int USA_NewYork_GMT_End      = 22;
   
   int USA_Chicago_GMT_Start    = 14;
   int USA_Chicago_GMT_End      = 23;
   
   int Asia_Tokyo_GMT_Start     = 0;
   int Asia_Tokyo_GMT_End       = 9;
   
   int Asia_HongKong_GMT_Start  = 1;
   int Asia_HongKong_GMT_End    = 10;
   
   int Pacific_Sydney_GMT_Start = 22;
   int Pacific_Sydney_GMT_End   = 7;
   
   int Pacific_Wellington_GMT_Start  = 22;
   int Pacific_Wellington_GMT_End    = 6;
   //--- Market Sessions Hours

#import "OrdersManagement.ex4"   
   int hours_from_session_start(int session_start);
   bool is_market_session_open(int session_start, int session_end);
   void get_pivots(string symbol, int timeframe);
   
   double getPrice(string Pair, int TimeFrame, int Mode, int shift);
   datetime getTimeToGMT(datetime time1);
   int getHigherTimeFrame(int sig_timeFrame);
   
   void getNearestAndFarestSR(string symbol, int timeframe, double price, double& pivots[]);
   
   double sqGetPipValue(string symbol);
   double sqGetPipDigits(string symbol);
   double sqGetStopLevelInPips(string symbol);
   double sqGetEqualityTolerance(string symbol);
   
   bool sqCheckTradeLevelsToSetBe(string symbol, int orderMagicNumber, double Break_Even_in_Pips, double Break_Even_Trigger_in_Pips, bool force=false);
   bool sqOrderIsInBeOrFurther(int orderTicket, double Break_Even_in_Pips, double Break_Even_Trigger_in_Pips);
   bool sqOrderIsTriggeredByBe(int orderTicket, double Break_Even_in_Pips, double Break_Even_Trigger_in_Pips);
   bool sqSetBreakEven(int orderTicket, double Break_Even_in_Pips, double Break_Even_Trigger_in_Pips);
   
   double getOrderPrice(string symbol, int orderType);
   double getOrderSize(string symbol, int orderMagicNumber, int orderType);
   double getOrderTrailingStop(string symbol, int timeFrame, int orderMagicNumber, int orderType, int trailingStopPips);
   double getOrderTrailingStopActivation(string symbol, int orderMagicNumber, int orderType, int addPips);
   double getOrderBreakEven(string symbol, int orderMagicNumber, int orderType, double price, int addPips);
   double getOrderBreakEvenAddPips(string symbol, int orderMagicNumber, int addPips);
   double getOrderExpiration(string symbol, int orderMagicNumber);
   double getOrderExitAfterXBars(string symbol, int orderMagicNumber);
   double getStopDifferencePrice(string symbol, int orderMagicNumber);
   double getOrderStopLoss(string symbol, int orderMagicNumber, int orderType, double price);
   double getOrderProfitTarget(string symbol, int orderMagicNumber, int orderType, double price);
   double getPointCoef(string symbol, int orderMagicNumber);
   double sqGetPointPow(string symbol);
   double sqGetPointCoef(string symbol);
   double sqConvertToRealPips(string symbol, int value);
   double sqConvertToPips(string symbol, double value);
   double sqSafeDivide(double var1, double var2);
   datetime sqGetTime(int hour, int minute, int second);
   int sqGetBarsSinceExit(string symbol, int orderMagicNumber);
   int sqGetOpenBarsForOrder(string symbol, int expBarsPeriod);
   int sqGetOrdersOpenedToday(string symbol, int direction, string includePending);
   
   double sqGetProfitToday(string symbol, int orderMagicNumber);
   int sqGetProfitablePositionToday(string symbol, int orderMagicNumber);
   int sqGetOpenedPositionOlderThanToday(string symbol, int orderMagicNumber);
   
   double sqOrderClosedProfit(string symbol, int orderTicket, int orderMagicNumber);
   
   int sqGetLastOrderType(string symbol, int orderMagicNumber);
   int sqGetLastOrderTodayType(string symbol, int orderMagicNumber);
   
   bool sqOrderOpenedThisBar(string symbol, int orderMagicNumber);
   
   bool sqOrderClosedThisBar(string symbol, int orderMagicNumber);
   double sqOrderClosedThisBarProfit(string symbol, int orderMagicNumber);
   int sqOrderClosedThisSeries(string symbol, int orderTicket, int orderMagicNumber);
   
   bool sqOrderOpenedThisMinute(string symbol, int orderMagicNumber);
   bool sqOrderClosedThisMinute(string symbol, int orderMagicNumber);
   
   
   double sqGetAngle(double value1, double value2, int period, double coef);
   string sqGetOrderSymbol(string symbol, int orderMagicNumber);
   string sqGetPeriodAsStr();
   string sqGetTimeFrameAsStr(int time_frame);
   string sqGetOrderTypeAsString(int type);
   int sqGetBarsFromOrderOpen(string symbol, int expBarsPeriod);
   int sqGetBarsFromOrderClose(string symbol, int expBarsPeriod);

   int sqGetMarketPosition(string symbol, int orderMagicNumber);
   int sqGetMarketWinPosition(string symbol, int orderMagicNumber);
   double sqGetMarketLot(string symbol, int orderMagicNumber);
   
   double sqGetMarketPipDistance(string symbol, int orderMagicNumber);
   double sqGetMaxMarketPipDistance(string symbol, int orderMagicNumber);
   double sqGetOrderPipDistance(string symbol, int orderTicket);
   
   double sqGetOrderPosition(string symbol, int orderType, int orderMagicNumber);
   double sqGetOpenPrice(string symbol, int orderMagicNumber);
   double sqGetOrderStopLoss(string symbol, int orderMagicNumber);
   double sqGetOrderProfitTarget(string symbol, int orderMagicNumber);
   void sqDeletePendingOrder(string symbol, int orderType, int orderMagicNumber);
   bool sqLiveOrderExists(string symbol, int orderMagicNumber);
   bool sqPendingOrderExists(string symbol, int orderType, int orderMagicNumber);
   bool getReplaceStopLimitOrder(int orderMagicNumber);
   double sqGetOrdersAveragePrice(string symbol, int orderMagicNumber);
   double sqGetIf (string symbol, double condition, double val1, double val2);
   double sqRound(double value, int digits);
   double sqGetAsk(string symbol);
   double sqGetBid(string symbol);
   bool sqDoublesAreEqual(string symbol, double n1, double n2);
   int sqIsTradeAllowed(int MaxWaiting_sec = 30);
   int sqOpenOrderWithErrorHandling(string symbol, int orderType, double orderLots, double price, int slippage, double realSL, double realPT, string comment, int orderMagicNumber, bool SupportECNBrokers = true, bool CloseAtError = false);
   bool sqSetSLPTForOrder(int ticket, double realSL, double realPT, int orderMagicNumber, int orderType, double price, int slippage, string symbol, int retries, bool closeAtError);
   bool sqClosePositionAtMarket(double size, int slippage);
   bool sqClosePositionWithHandling(double size, int slippage);
   bool sqOpenOrder(string symbol, int orderType, double orderLots, double price, int slippage, double realSL, double realPT, string comment, int orderMagicNumber, string ruleName, datetime expiration = 0);
   double sqMMGetOrderStopLossDistance(string symbol, int orderMagicNumber, int orderType);
   double sqMMFixedRisk(string symbol, int orderMagicNumber, int orderType, double riskInPercent = 0, double lotsIfNoMM = 0.01, double lotsDecimals = 2, double maximumLots = 10,string pairSuffix = "");
   
   void Verbose(string s1, string s2="", string s3="", string s4="", string s5="", string s6="", string s7="", string s8="", string s9="", string s10="", string s11="", string s12="", int VerboseMode = 0);
   void VerboseLog(string s1, string s2="", string s3="", string s4="", string s5="", string s6="", string s7="", string s8="", string s9="", string s10="", string s11="", string s12="", int VerboseMode = 1);
   void Log(string s1, string s2="", string s3="", string s4="", string s5="", string s6="", string s7="", string s8="", string s9="", string s10="", string s11="", string s12="" );
   void LogToFile(string fileName, string s1, string s2="", string s3="", string s4="", string s5="", string s6="", string s7="", string s8="", string s9="", string s10="", string s11="", string s12="" );
#import