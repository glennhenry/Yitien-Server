package com.yiTian.view.modules.paoku.userCom
{
   import com.yiTian.view.modules.paoku.core.state.StateMachie;
   import com.yiTian.view.modules.paoku.userCom.state.KuPaoGameingState;
   import com.yiTian.view.modules.paoku.userCom.state.KuPaoGameoverState;
   import com.yiTian.view.modules.paoku.userCom.state.KuPaoHelpState;
   import com.yiTian.view.modules.paoku.userCom.state.KuPaoLogoState;
   import com.yiTian.view.modules.paoku.userCom.state.KuPaoStartMenuState;
   import com.yiTian.view.modules.paoku.userCom.util.Config;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class KuPaoMgr
   {
      
      private static var _instance:KuPaoMgr;
      
      public static const GST_LOGO:int = 1;
      
      public static const GST_STARTMENU:int = 2;
      
      public static const GST_GAMESTART:int = 3;
      
      public static const GST_GAMEOVER:int = 4;
      
      public static const GST_HELP:int = 5;
      
      public static const MGS_SCORE_ADD:String = "kp_ScoreAdd";
      
      public var paokuGlobalSM:StateMachie;
      
      public var focusPoint:Point = new Point();
      
      public var configXMls:Array = [];
      
      public var blockInfoDict:Dictionary = new Dictionary();
      
      public function KuPaoMgr()
      {
         super();
         this.configureStates();
      }
      
      public static function get instance() : KuPaoMgr
      {
         return _instance = _instance || new KuPaoMgr();
      }
      
      public function update() : void
      {
         this.paokuGlobalSM.smUpdate(this);
      }
      
      public function configureStates() : void
      {
         this.paokuGlobalSM = new StateMachie();
         this.paokuGlobalSM.setState(GST_LOGO,new KuPaoLogoState());
         this.paokuGlobalSM.setState(GST_STARTMENU,new KuPaoStartMenuState());
         this.paokuGlobalSM.setState(GST_GAMESTART,new KuPaoGameingState());
         this.paokuGlobalSM.setState(GST_HELP,new KuPaoHelpState());
         this.paokuGlobalSM.setState(GST_GAMEOVER,new KuPaoGameoverState());
      }
      
      public function getIndexArr(xPos:int) : Array
      {
         var globalCol:int = xPos / Config.BLOCK_WID;
         return this.blockInfoDict[globalCol];
      }
      
      public function getType(xPos:int, yPos:int) : int
      {
         var localx:int = 0;
         var row:int = 0;
         var col:int = 0;
         if(yPos < 0)
         {
            return 0;
         }
         var arr:Array = this.getIndexArr(xPos);
         if(Boolean(arr))
         {
            localx = xPos % Config.BLOCK_WID;
            row = yPos / Config.TILE_HEI;
            col = localx / Config.TILE_WID;
            return arr[row][col];
         }
         return -1;
      }
   }
}

