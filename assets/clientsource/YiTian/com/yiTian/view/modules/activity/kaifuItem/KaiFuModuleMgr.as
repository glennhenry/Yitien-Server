package com.yiTian.view.modules.activity.kaifuItem
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.view.modules.activity.Enum_KF;
   import com.yiTian.view.modules.activity.kaifuItem.tuangou.Child_ShouChongTuanGou;
   import com.yiTian.view.modules.activity.kaifuItem.tuangou.Child_WuHunTuanGou;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class KaiFuModuleMgr extends EventDispatcher
   {
      
      private static var _instance:KaiFuModuleMgr;
      
      public static const GEM_REWARD:int = 18;
      
      public static const TBTN_STATE_CHANGE:String = "kaifu_btn_state_change";
      
      public var stateDict:Dictionary = new Dictionary();
      
      public var btnEffectDict:Dictionary = new Dictionary();
      
      public var objs:Object = new Object();
      
      public function KaiFuModuleMgr()
      {
         super();
         this.init();
      }
      
      public static function get instance() : KaiFuModuleMgr
      {
         return _instance = _instance || new KaiFuModuleMgr();
      }
      
      public function init() : void
      {
         this.objs["14"] = 4;
         this.objs["15"] = 3;
         this.objs["16"] = 7;
         this.objs["1"] = 5;
         this.objs["2"] = 5;
         this.objs["3"] = 5;
         this.objs[17] = "BQ_Zhe";
         this.objs[18] = "BQ_Song";
         this.objs[19] = "BQ_Zhe";
         this.objs[20] = "BQ_Tuan";
         this.objs[21] = "BQ_Tuan";
         this.objs[22] = "BQ_Tuan";
         this.objs[23] = "BQ_Bi";
         this.objs[24] = "BQ_Bi";
         this.objs[25] = "BQ_Bi";
      }
      
      public function getView(id:int) : Child_KaifuViewBase
      {
         var actLib:Dictionary = Data_lib.kfhd;
         if(id == 19)
         {
            return Child_KaiFuGemDiscount.instance;
         }
         if(id == 18)
         {
            return Child_KaiFuGemReward.instance;
         }
         if(id == 17)
         {
            return Child_KaiFuPurchasing.instance;
         }
         if(id == 23)
         {
            return Child_KFCJPanel.instance;
         }
         if(id == 24)
         {
            return Child_KFWLPanel.instance;
         }
         if(id == 25)
         {
            return Child_KFBPPanel.instance;
         }
         if(id == Enum_KF.ID_SHOUCHONGTUANGOU)
         {
            return Child_ShouChongTuanGou.instance;
         }
         if(id == Enum_KF.ID_WUHUNTUANGOU || id == Enum_KF.ID_ZUOQITUANGOU)
         {
            return Child_WuHunTuanGou.instance;
         }
         return null;
      }
      
      public function getSpecActIDs() : Array
      {
         var k:String = null;
         var rest:Array = [];
         for(k in this.stateDict)
         {
            if(this.stateDict[k] > 0)
            {
               rest.push(int(k));
            }
         }
         return rest;
      }
      
      public function setState(id:int, state:*) : void
      {
         if(this.stateDict[id] != state)
         {
            this.stateDict[id] = state;
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function setBtnEffect(id:int, state:int, iconImg:* = null) : void
      {
         this.btnEffectDict[id] = state;
         Global.control.sendNotification(TBTN_STATE_CHANGE,[id,state,iconImg]);
      }
      
      public function clearBtnEffects() : void
      {
         var k:String = null;
         for(k in this.btnEffectDict)
         {
            this.btnEffectDict[k] = null;
         }
      }
   }
}

