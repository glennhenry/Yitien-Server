package com.yiTian.view.modules.activity.kaifuItem
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.net.message.cg.GuideCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.activity.Enum_KF;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import mx.utils.StringUtil;
   
   public class CCBtn extends Sprite
   {
      
      private static var _time:int;
      
      private static var isFrame:Boolean = false;
      
      private static var comStr:String = "请输入激活码领取礼包";
      
      private static var gridPool:Array = [];
      
      private static var pool:Array = [];
      
      public var discript:String;
      
      private var tf_label:MyTextField;
      
      private var btn_get:Button;
      
      public var taskID:int;
      
      private var gridArr:Array;
      
      private var line:ScaleBitmap;
      
      private var _state:int;
      
      private var speBtn:Button;
      
      public var id:int;
      
      private var _label:String;
      
      private var remainTxt:MyTextField;
      
      public var _id:int;
      
      public var index:int;
      
      private var KFInfo:Object = {
         "14":["当前玩家：{0}","剩余{0}个名额"],
         "15":[null,"剩余{0}个名额"],
         "16":[null,"剩余{0}个名额"]
      };
      
      private var _last:int;
      
      private var speGridArr:Array;
      
      private var speInputTxt:MyTextField;
      
      private var strInput:String;
      
      private var _tf:MyTextField;
      
      private var speBG:ScaleBitmap;
      
      public function CCBtn()
      {
         super();
         this.line = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],null,{
            "x":-10,
            "width":410,
            "height":2
         },Global.Img_Cdm);
         addChild(this.line);
         this.remainTxt = ComponentUtil.getTextField("",this,{
            "x":310,
            "y":8,
            "color":14013809,
            "realWidth":140,
            "wordWrap":true
         },TextFieldAutoSize.CENTER);
         this.tf_label = ComponentUtil.getTextField("",this,{
            "y":9.75,
            "color":14013809
         });
         this.tf_label.mouseEnabled = true;
         this.btn_get = ComponentUtil.getButton("","Button_Orange",this,{
            "x":310,
            "y":8
         },Global.Img_Cdm);
         this.speBtn = ComponentUtil.getButton("","Button_Orange",this,{
            "x":310,
            "y":8
         },Global.Img_Cdm);
         this.speBtn.visible = false;
         this._tf = ComponentUtil.getTextField("",null,{"color":14013822});
         this.gridArr = [];
         this.speGridArr = [];
         this.btn_get.callBack = this.btnClickHd;
         this.speBtn.callBack = this.speBtnClickHd;
      }
      
      private static function getGrid() : View_Grid
      {
         if(Boolean(gridPool.length))
         {
            return gridPool.pop();
         }
         var grid:View_Grid = new View_Grid();
         grid.set_bmp_bg();
         grid.set_bmp_over(true,null);
         grid.set_tf_count(true,true,true);
         return grid;
      }
      
      public static function getI() : CCBtn
      {
         var ccBtn:CCBtn = Boolean(pool.length) ? pool.pop() : new CCBtn();
         ccBtn.state = -1;
         return ccBtn;
      }
      
      private function speBtnClickHd(e:MouseEvent) : void
      {
         if(!this.speInputTxt)
         {
            return;
         }
         if(this.speInputTxt.htmlText == "" || this.speInputTxt.htmlText == this.strInput)
         {
            UIManager.centerBroadcast.addMsg("请输入相应新手卡号");
            return;
         }
         GuideCGMessage.CG_GET_NEWPAWARD(this.speInputTxt.text);
      }
      
      private function btnClickHd(evt:MouseEvent) : void
      {
         var type:int = 0;
         var tmp:Array = null;
         var rnd:int = 0;
         var str:String = null;
         if(Boolean(this.KFInfo[this._id + ""]))
         {
            switch(this._id)
            {
               case Enum_KF.ID_HORSE:
                  if(this.index < 4)
                  {
                     type = 1;
                  }
                  else
                  {
                     type = 2;
                  }
                  DailyActCGMessage.CG_HORSE_GETAWARD(type);
                  break;
               case Enum_KF.ID_ZL:
                  DailyActCGMessage.CG_KF_ZLSC_GETAWARD(Enum_KF.TYPE_ZL,this.index + 1);
                  break;
               case Enum_KF.ID_BB:
                  DailyActCGMessage.CG_KF_ZLSC_GETAWARD(Enum_KF.TYPE_SC,this.index + 1);
            }
            return;
         }
         if(this.taskID >= 35 && this.taskID <= 37)
         {
            DailyActCGMessage.CG_GETKFHDREWARD2(this.taskID - 34);
         }
         else if(this.taskID == 31 && this._state == 0)
         {
            DailyActCGMessage.CG_DAILYSHARE();
            tmp = [29232,29233,29237,29240,29241,29242,29244];
            rnd = int(Math.random() * tmp.length);
            str = LangConfig.getWord(tmp[rnd],2);
            ExternalInterface.call("share",encodeURI(LangConfig.getWord("29191",2)),encodeURI(str),encodeURI(LangConfig.getWord("29190",2)));
         }
         else if(this.id == 12)
         {
            if(_time > 0)
            {
               UIManager.centerBroadcast.addMsg("请稍等" + _time.toString() + "秒");
               return;
            }
            if(this.speInputTxt.text == comStr || this.speInputTxt.text == "")
            {
               UIManager.centerBroadcast.addMsg("请输入激活码");
               return;
            }
            GuideCGMessage.CG_GET_NEWPAWARD(this.speInputTxt.text);
         }
         else
         {
            DailyActCGMessage.CG_GETKFHDREWARD(this.taskID);
         }
      }
      
      public function set state(value:int) : void
      {
         this.speBtn.visible = false;
         this.btn_get.visible = true;
         switch(value)
         {
            case -1:
            case 0:
               if(this.taskID == 31)
               {
                  this.btn_get.label = LangConfig.getWord("29234",2);
                  this.btn_get.enabled = true;
                  break;
               }
               this.btn_get.label = LangConfig.getWord("29074",2);
               this.btn_get.enabled = false;
               break;
            case 1:
               this.btn_get.label = LangConfig.getWord("29073",2);
               this.btn_get.enabled = true;
               break;
            case 2:
               this.btn_get.label = LangConfig.getWord("29075",2);
               this.btn_get.enabled = false;
               break;
            case 3:
               this.btn_get.label = LangConfig.getWord("29243",2);
               this.btn_get.enabled = false;
               break;
            case 11:
               this.btn_get.visible = false;
               this.speBtn.visible = true;
               this.speBtn.label = "确定领取";
               this.btn_get.enabled = true;
               if(Boolean(this.speInputTxt))
               {
                  this.speInputTxt.type = TextFieldType.INPUT;
               }
               this.tf_label.htmlText = "";
               break;
            case 12:
               this.btn_get.label = "领取奖励";
               this.btn_get.enabled = false;
         }
         this._state = value;
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set btnCon(value:int) : void
      {
         switch(value)
         {
            case 0:
               this.speBtn.enabled = true;
               break;
            case 1:
               this.speBtn.enabled = false;
               this.speBtn.label = "已领取";
               if(Boolean(this.speInputTxt))
               {
                  this.speInputTxt.type = TextFieldType.DYNAMIC;
               }
               if(Boolean(this.speInputTxt))
               {
                  this.speInputTxt.text = "";
               }
         }
      }
      
      public function showTaskAni() : void
      {
         var tgrid:View_Grid = null;
         var grid:View_Grid = null;
         var i:int = 0;
         var b:int = this.taskID;
         var rewards:Array = Data_lib.kfhd[this.taskID];
         var times:int = 10;
         for each(tgrid in this.gridArr)
         {
            times = Math.min(times,tgrid.vo.count);
         }
         for each(grid in this.gridArr)
         {
            i = 0;
            while(i < times)
            {
               this.s(grid,i * 200);
               i += 1;
            }
         }
      }
      
      public function getNewerGift() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         for each(grid in this.speGridArr)
         {
            i = 0;
            while(i < this.speGridArr.length)
            {
               this.s(grid,200);
               i += 1;
            }
         }
      }
      
      private function s(grid:View_Grid, time:uint) : void
      {
         var toIndex:int = 0;
         toIndex = int(setTimeout(function():void
         {
            ComboTweenStep.toBag(grid,0,0,function():void
            {
               clearTimeout(toIndex);
            },"bsToBag");
         },time));
      }
      
      private function endFun(target:Bitmap) : void
      {
         target.parent.removeChild(target);
         target.bitmapData = null;
      }
      
      public function set label(str:String) : void
      {
         this._label = str;
         this.alginContiner();
      }
      
      private function alginContiner() : void
      {
         var arr:Array = null;
         var ob:Object = null;
         var str:String = null;
         var tips:String = null;
         var asrr:Array = null;
         var k:int = 0;
         this.remainTxt.htmlText = "";
         this.tf_label.htmlText = this._label;
         this.tf_label.y = 9.75;
         if(Boolean(this.KFInfo[this._id + ""]))
         {
            arr = this.KFInfo[this._id + ""] as Array;
            this._label = StringUtil.substitute(this._label,arr[0]);
            this.tf_label.y = 2.75;
            ob = Model_actDaily.getSub(this._id,this.index);
            if(Boolean(ob))
            {
               if(Boolean(arr[1]) && ob.reamain > -1)
               {
                  this.remainTxt.htmlText = StringUtil.substitute(arr[1],ob.reamain);
               }
               if(Boolean(arr[0]) && Boolean(ob.name) && ob.name.length > 1)
               {
                  this.tf_label.y = 2.75;
                  str = ob.name.length > 6 ? (ob.name as String).slice(0,4) + ".." : ob.name;
                  this.tf_label.htmlText = this._label + "\n" + "<u>" + StringUtil.substitute(arr[0],str) + "</u>";
                  tips = "当前玩家：\n";
                  if((ob.name as String).indexOf(";") != -1)
                  {
                     asrr = (ob.name as String).split(";");
                     k = 0;
                     while(k < asrr.length)
                     {
                        tips += " " + asrr[k] + "\n";
                        k++;
                     }
                  }
                  else
                  {
                     tips += " " + ob.name;
                  }
                  TipManager.bind(this.tf_label,tips);
               }
               else
               {
                  TipManager.unBind(this.tf_label);
               }
            }
         }
         if(Boolean(this.remainTxt.text.length))
         {
            this.btn_get.y = 0;
            this.remainTxt.y = 22;
            this.remainTxt.visible = true;
         }
         else
         {
            this.btn_get.y = 8;
            this.remainTxt.visible = false;
         }
      }
      
      public function setData(value:Array) : void
      {
         var type:int = 0;
         var id:int = 0;
         var num:int = 0;
         var vo:Vo_valuable = null;
         var grid:View_Grid = null;
         this.discript = "";
         var i:int = 0;
         while(i < value.length)
         {
            type = int(value[i][0]);
            id = int(value[i][1]);
            num = int(value[i][2]);
            switch(type)
            {
               case 1:
                  vo = new Vo_item();
                  vo.id = id;
                  vo.count = num;
                  (vo as Vo_item).Init_lib();
                  break;
               case 2:
                  vo = new Vo_equip();
                  vo.id = id;
                  vo.count = num;
                  (vo as Vo_equip).Init_lib();
            }
            grid = getGrid();
            grid.vo = vo;
            this.gridArr.push(grid);
            i += 1;
         }
         this.line.y = 38;
         this.alignGrid();
      }
      
      private function removeFrameHd() : void
      {
         GameScene.instance.removeFrameCallBack(this.frameHandle);
         isFrame = false;
      }
      
      private function frameHandle(interenal:int) : void
      {
         var _now:int = getTimer();
         isFrame = true;
         if(_now - this._last >= 1000)
         {
            --_time;
            this._last = _now;
            if(_time == 0)
            {
               this.removeFrameHd();
            }
         }
      }
      
      public function setBtnEnbaled(value:Boolean, time:int) : void
      {
         if(!value)
         {
            _time = time;
            if(!isFrame)
            {
               GameScene.instance.addFrameCallBack(this.frameHandle);
            }
         }
      }
      
      public function set_data(arr:Array) : void
      {
         var str:String;
         var vo:Vo_valuable = null;
         var type:int = 0;
         var id:int = 0;
         var num:int = 0;
         var grid:View_Grid = null;
         var i:int = 0;
         while(i < arr.length)
         {
            type = int(arr[i]);
            id = int(arr[i + 1]);
            num = int(arr[i + 2]);
            switch(type)
            {
               case 1:
                  vo = new Vo_item();
                  vo.id = id;
                  vo.count = num;
                  (vo as Vo_item).Init_lib();
                  break;
               case 2:
                  vo = new Vo_equip();
                  vo.id = id;
                  vo.count = num;
                  (vo as Vo_equip).Init_lib();
            }
            grid = getGrid();
            grid.vo = vo;
            this.speGridArr.push(grid);
            i += 3;
         }
         this.line.y = 40;
         this.alignSpeGrid();
         str = vo.str_name.split("礼包").join("");
         this.strInput = "请输入" + HtmlUtil.font(str,"#f9ff00") + "激活码领取礼包";
         this.speInputTxt = ComponentUtil.getTextField("",this,{
            "x":88,
            "y":8,
            "realWidth":200,
            "realHeight":22,
            "maxChars":10,
            "color":14013822
         });
         this.speInputTxt.htmlText = this.strInput;
         this._tf.htmlText = this.strInput;
         this.speInputTxt.type = TextFieldType.INPUT;
         this.speInputTxt.setSelection(this.speInputTxt.text.length,this.speInputTxt.text.length);
         this.speInputTxt.addEventListener(FocusEvent.FOCUS_IN,function(e:FocusEvent):void
         {
            if(speInputTxt.htmlText == _tf.htmlText)
            {
               speInputTxt.htmlText = "";
            }
            speInputTxt.color = 14013822;
         });
         this.speInputTxt.addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void
         {
            speInputTxt.color = 14013822;
            if(speInputTxt.htmlText == "")
            {
               speInputTxt.htmlText = strInput;
            }
         });
      }
      
      public function setData_twelv() : void
      {
         if(_time != 0)
         {
            this.setBtnEnbaled(false,_time);
         }
         if(!this.speBG)
         {
            this.speBG = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
               "x":87,
               "y":5,
               "width":200,
               "height":28
            },Global.Img_Cdm);
         }
         if(!this.speBG.visible)
         {
            this.speBG.visible = true;
         }
         this.strInput = comStr;
         this.speInputTxt = ComponentUtil.getTextField("",this,{
            "x":88,
            "y":8,
            "realWidth":200,
            "realHeight":22,
            "maxChars":50,
            "color":14013822
         });
         this.speInputTxt.htmlText = this.strInput;
         this._tf.htmlText = this.strInput;
         this.speInputTxt.type = TextFieldType.INPUT;
         this.speInputTxt.setSelection(this.speInputTxt.text.length,this.speInputTxt.text.length);
         this.speInputTxt.addEventListener(FocusEvent.FOCUS_IN,function(e:FocusEvent):void
         {
            if(speInputTxt.htmlText == _tf.htmlText)
            {
               speInputTxt.htmlText = "";
            }
            speInputTxt.color = 14013822;
         });
         this.speInputTxt.addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void
         {
            speInputTxt.color = 14013822;
            if(speInputTxt.htmlText == "")
            {
               speInputTxt.htmlText = strInput;
            }
         });
      }
      
      private function alignSpeGrid() : void
      {
         var grid:View_Grid = null;
         if(!this.speGridArr.length)
         {
            return;
         }
         var i:int = 0;
         while(i < this.speGridArr.length)
         {
            grid = this.speGridArr[i];
            grid.x = 0;
            grid.y = 1;
            addChild(grid);
            i++;
         }
      }
      
      private function alignGrid() : void
      {
         var grid:View_Grid = null;
         if(!this.gridArr.length)
         {
            return;
         }
         var w:Number = 40 * this.gridArr.length + 7 * (this.gridArr.length - 1);
         var sx:Number = (400 - w) / 2 + 6;
         var i:int = 0;
         while(i < this.gridArr.length)
         {
            grid = this.gridArr[i];
            grid.x = sx + (40 + 7) * i;
            addChild(grid);
            i += 1;
         }
      }
      
      public function save() : void
      {
         var grid:View_Grid = null;
         var _grid:View_Grid = null;
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         pool.push(this);
         for each(grid in this.gridArr)
         {
            gridPool.push(grid);
            removeChild(grid);
         }
         for each(_grid in this.speGridArr)
         {
            gridPool.push(_grid);
            removeChild(_grid);
         }
         if(Boolean(this.speInputTxt))
         {
            removeChild(this.speInputTxt);
            this.speInputTxt = null;
         }
         if(Boolean(this.speBG))
         {
            this.speBG.visible = false;
         }
         this.speGridArr.splice(0);
         this.gridArr.splice(0);
      }
   }
}

