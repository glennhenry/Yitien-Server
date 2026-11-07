package com.yiTian.view.modules.yellowDiamond
{
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.SocketManager;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   
   public class ActionsCtrl
   {
      
      private static var paramArrSave:Dictionary = new Dictionary();
      
      public static var list:Dictionary = new Dictionary();
      
      private static var isAllInit:Boolean = false;
      
      private static var bytebuff:ByteArray = new ByteArray();
      
      public function ActionsCtrl()
      {
         super();
      }
      
      public static function initPHPParam(param:Object) : void
      {
         var key:String = null;
         for(key in param)
         {
            paramArrSave[key] = param[key];
         }
      }
      
      public static function init() : void
      {
         var ctrlStr:String = null;
         var url:String = null;
         var platForm:String = null;
         var lvl:int = 0;
         var linkAddress:String = null;
         var type:int = 0;
         var isHide:int = 0;
         var param:String = null;
         var effectParam:String = null;
         var waitForServer:String = null;
         var send_to_server:String = null;
         var receiver_from_server:String = null;
         var removeTime:int = 0;
         initCmdDic();
         var len:int = int(Data_lib.actionsTX.getLength());
         var i:int = 1;
         while(i <= len)
         {
            ctrlStr = Data_lib.actionsTX[i][3];
            if(Boolean(paramArrSave[ctrlStr]))
            {
               url = Data_lib.actionsTX[i][0];
               platForm = Data_lib.actionsTX[i][2];
               lvl = int(Data_lib.actionsTX[i][1]);
               linkAddress = Data_lib.actionsTX[i][4];
               type = int(Data_lib.actionsTX[i][5]);
               isHide = int(Data_lib.actionsTX[i][6]);
               param = Data_lib.actionsTX[i][7];
               effectParam = Data_lib.actionsTX[i][8];
               waitForServer = Data_lib.actionsTX[i][9];
               send_to_server = Data_lib.actionsTX[i][10];
               receiver_from_server = Data_lib.actionsTX[i][10];
               removeTime = int(Data_lib.actionsTX[i][12]);
               if(platForm == "all" || compareToPlatForm(platForm))
               {
                  InerClass.instance.add(url,lvl,linkAddress,type,isHide,param,effectParam,waitForServer,send_to_server,receiver_from_server,removeTime);
               }
            }
            i++;
         }
         isAllInit = true;
         Global.control.sendNotification("acTionsCtrl",null);
      }
      
      private static function compareToPlatForm(platForm:String) : Boolean
      {
         var arr:Array = null;
         var pp:String = null;
         if(platForm.indexOf(";") == -1)
         {
            return Global.pf == platForm;
         }
         arr = platForm.split(";");
         for each(pp in arr)
         {
            if(pp == Global.pf)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function register(key:int, func:Function) : void
      {
         if(!list[key])
         {
            list[key] = func;
         }
      }
      
      public static function send_to_server(cmd:int, arr:Array = null) : void
      {
         var i:int = 0;
         var b:int = 0;
         bytebuff.length = 0;
         if(arr != null)
         {
            i = 0;
            while(i < arr.length)
            {
               b = int(arr[i]);
               bytebuff.writeByte(b);
               i++;
            }
         }
         SocketManager.send(cmd,bytebuff);
      }
      
      public static function initCmdDic() : void
      {
         SocketManager.index[163002] = microPay;
      }
      
      private static function microPay(patch:IDataInput) : void
      {
         var arr:Array = null;
         var handle_data:Function = null;
         handle_data = function():void
         {
            var key:int = 0;
            var i:int = 0;
            while(i < arr.length)
            {
               key = int(arr[i]);
               if(Boolean(list[key]))
               {
                  list[key]();
               }
               i++;
            }
         };
         var status:String = patch.readUTF();
         arr = status.split("_");
         if(isAllInit)
         {
            handle_data();
         }
         else
         {
            Global.control.registerCallBack("acTionsCtrl",handle_data);
         }
      }
   }
}

import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.gameUnit.magic.Effect;
import com.yiTian.manager.EffectManager;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.UIManager;
import com.yiTian.view.modules.actions.xsHaoli.LinkManager;
import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
import com.yiTian.view.modules.yellowDiamond.ActionFactory;
import com.yiTian.view.modules.yellowDiamond.ActionsCtrl;
import flash.external.ExternalInterface;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

class InerClass
{
   
   private static var pool:Array = [];
   
   private var url:String;
   
   private var lvl:int;
   
   private var linkAddress:String;
   
   private var type:int;
   
   private var isHide:Boolean;
   
   private var param:Array;
   
   private var _effectParam:String;
   
   private var waitForServer:int;
   
   private var send_to_server:int;
   
   private var send_to_server_param:Array;
   
   private var receiver_from_server:int;
   
   private var removeTime:int;
   
   private var isRegTheFunction:Boolean = false;
   
   public function InerClass()
   {
      super();
      trace("do nothing");
   }
   
   public static function get instance() : InerClass
   {
      return Boolean(pool.length) ? pool.pop() : new InerClass();
   }
   
   public function add(url:String, lvl:int, linkAddress:String, type:int, isHide:int, _param:String, effectParam:String, waitForServer:String, send_to_server:String, receiver_from_server:String, removeTime:int) : void
   {
      var i:int = 0;
      var nn:int = 0;
      this.url = url;
      this.lvl = lvl;
      this.linkAddress = linkAddress;
      this.type = type;
      this.isHide = isHide == 1;
      this.param = this.explainParam(_param);
      this._effectParam = effectParam;
      this.waitForServer = int(waitForServer);
      this.removeTime = removeTime;
      var _tArr:Array = send_to_server.split("_");
      this.send_to_server = int(_tArr[0]);
      this.send_to_server_param = [];
      if(_tArr.length >= 2)
      {
         i = 1;
         while(i < _tArr.length)
         {
            nn = int(_tArr[i]);
            this.send_to_server_param.push(nn);
            i++;
         }
      }
      this.receiver_from_server = int(receiver_from_server);
      this.show();
   }
   
   private function explainParam(_param:String) : Array
   {
      if(_param.indexOf(";") == -1)
      {
         return [_param];
      }
      return _param.split(";");
   }
   
   private function show() : void
   {
      if(GameUnitManager.hero.level < this.lvl)
      {
         if(!this.isRegTheFunction)
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_LV_UP,this.show);
            this.isRegTheFunction = true;
         }
         return;
      }
      Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP,this.show);
      this.isRegTheFunction = false;
      if(this.waitForServer > 0)
      {
         ActionsCtrl.register(this.waitForServer,this.addBtn);
      }
      else
      {
         this.addBtn();
      }
   }
   
   private function addBtn() : void
   {
      var btn:MainUIBtn = null;
      var flag:int = 0;
      btn = this.createBtn();
      if(this.removeTime > 0)
      {
         flag = int(setTimeout(function():void
         {
            clearTimeout(flag);
            if(Boolean(btn) && UIManager.mainUiBtnContainer.hasBTN(btn))
            {
               UIManager.mainUiBtnContainer.removeBTN(btn);
               btn = null;
            }
            else if(Boolean(btn) && UIManager.newMainBtnContainer.hasBtn(btn))
            {
               UIManager.newMainBtnContainer.removeBtn(btn);
               btn = null;
            }
         },this.removeTime));
      }
      LinkManager.jump(function():void
      {
         if(send_to_server != 0)
         {
            ActionsCtrl.send_to_server(send_to_server,send_to_server_param);
         }
         if(type == 1)
         {
            navigateToURL(new URLRequest(linkAddress),"_blank");
         }
         else if(type == 2)
         {
            if(param.length == 0)
            {
               ExternalInterface.call(linkAddress);
            }
            else if(param.length == 1)
            {
               ExternalInterface.call(linkAddress,param[0]);
            }
            else if(param.length == 2)
            {
               ExternalInterface.call(linkAddress,param[0],param[1]);
            }
            else if(param.length == 3)
            {
               ExternalInterface.call(linkAddress,param[0],param[1],param[2]);
            }
         }
         else
         {
            ActionFactory.doSomething(linkAddress);
         }
      },btn,this.isHide);
   }
   
   private function createBtn() : MainUIBtn
   {
      var eff:Effect = null;
      var del:Function = null;
      del = function():void
      {
         if(Boolean(eff))
         {
            EffectManager.removeEffect(eff);
            eff = null;
         }
      };
      var _effectArr:Array = this._effectParam.split("_");
      var btn:MainUIBtn = new MainUIBtn(this.url,{
         "x":0,
         "y":0
      });
      if(_effectArr[0] == 0)
      {
         return btn;
      }
      eff = EffectManager.addEffect(_effectArr[0].toString(),btn,1000,32,29,true);
      if(_effectArr[1] == 0)
      {
         return btn;
      }
      setTimeout(del,_effectArr[1]);
      return btn;
   }
   
   public function dispose() : void
   {
      Global.control.removeCallBack(Enum_MsgType.MSG_LV_UP_2,this.show);
      this.url = "";
      this.lvl = 0;
      this.linkAddress = "";
      this.send_to_server_param = null;
      this.send_to_server = 0;
      this.receiver_from_server = 0;
      this.waitForServer = 0;
      pool.push(this);
   }
}
