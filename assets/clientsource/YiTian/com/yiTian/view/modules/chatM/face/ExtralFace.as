package com.yiTian.view.modules.chatM.face
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.chatM.FaceChooser;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class ExtralFace extends Sprite
   {
      
      private static const btnStyleArr:Array = ["Button_Zhu","Button_LaoHu","Button_ZhangYu","Button_HouZi","Button_BaoZi"];
      
      private static const tipsStrArr:Array = ["升级为武魂可以使用","您还没有使用萌虎表情包哦","您还没有使用保罗表情包哦","您还没有使用福猴表情包哦","您还没有使用倚天包包哦"];
      
      public static const MSG_EEE:String = "msg_eee";
      
      public static const LABEL_LEN:int = 5;
      
      private var btnVec:Vector.<Button>;
      
      private var isInit:Boolean;
      
      public var dicPart:Dictionary = new Dictionary();
      
      public var selFun:Function;
      
      private var nowRollOverIndex:int;
      
      private var isRollOver:Boolean;
      
      public var nowChooseBtn:Button;
      
      private var nowShowIcon:Icons;
      
      public function ExtralFace()
      {
         super();
         ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "x":0,
            "y":0,
            "width":160,
            "height":160
         },Global.Img_Cdm);
      }
      
      private function initBtn() : void
      {
         var btn:Button = null;
         if(this.isInit == true)
         {
            return;
         }
         this.btnVec = new Vector.<Button>();
         var i:int = 0;
         while(i < LABEL_LEN)
         {
            btn = ComponentUtil.getButton("",btnStyleArr[i],this,{
               "x":161,
               "y":5 + 30 * i,
               "tabIndex":i + 1
            },Global.faceDm);
            btn.addEventListener(MouseEvent.CLICK,this.setChoose);
            btn.addEventListener(MouseEvent.MOUSE_DOWN,this.downEvent);
            this.btnVec.push(btn);
            btn.addEventListener(MouseEvent.ROLL_OVER,this.overEvent);
            btn.addEventListener(MouseEvent.ROLL_OUT,this.outEvent);
            i++;
         }
         this.btnChooseStatus();
      }
      
      public function show() : void
      {
         this.visible = visible || true;
         if(!this.isInit)
         {
            if(!Global.faceDm)
            {
               MassLoader.add("lang/ch/FaceIcons.swf",function(info:Object):void
               {
                  Global.faceDm = info.applicationDomain;
                  initBtn();
                  isInit = true;
               });
            }
            else
            {
               this.initBtn();
            }
         }
         else
         {
            this.btnChooseStatus();
         }
      }
      
      private function btnChooseStatus() : void
      {
         this.filtersHd();
         this.btnChooseHd();
      }
      
      private function btnChooseHd() : void
      {
         var obj:Object = null;
         var i:int = 0;
         if(GameUnitManager.hero.vip > 0)
         {
            this.getButton(this.btnVec[0]).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else if(Model_face.data.length == 0)
         {
            if(Boolean(parent))
            {
               parent.x += 95;
               this.nowChooseBtn = null;
               (parent as FaceChooser).hidePig();
            }
         }
         else
         {
            obj = this.getObjIndex();
            i = 1;
            while(i <= LABEL_LEN)
            {
               if(Boolean(obj[i]))
               {
                  this.getButton(this.btnVec[i - 1] as Button).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                  break;
               }
               i++;
            }
         }
      }
      
      private function getButton(btn:Button) : Button
      {
         if(Boolean(this.nowChooseBtn) && btn != this.nowChooseBtn)
         {
            return this.nowChooseBtn;
         }
         return btn;
      }
      
      private function getObjIndex() : Object
      {
         var arr:Array = null;
         var obj:Object = new Object();
         for each(arr in Model_face.data)
         {
            if(arr[1] > 0 && arr[0] > 0)
            {
               obj[arr[0] - 50000] = true;
            }
         }
         return obj;
      }
      
      private function filtersHd() : void
      {
         var obj:Object = this.getObjIndex();
         var i:int = 0;
         while(i < this.btnVec.length)
         {
            if(Boolean(obj[(i + 1).toString()]))
            {
               this.btnVec[i].filters = [];
            }
            else
            {
               this.btnVec[i].filters = Util.disabled;
            }
            i++;
         }
         if(GameUnitManager.hero.vip > 0)
         {
            this.btnVec[0].filters = [];
         }
      }
      
      private function overEvent(e:MouseEvent = null) : void
      {
         this.nowRollOverIndex = e.target.tabIndex;
         if(this.nowRollOverIndex == 50001)
         {
            return;
         }
         if(this.nowRollOverIndex > LABEL_LEN)
         {
            this.nowRollOverIndex = LABEL_LEN;
         }
         this.isRollOver = true;
      }
      
      private function updateTips(data:Object) : void
      {
         var _index:int = data.index - 50000;
         if(_index < 1)
         {
            _index = 1;
         }
         if(_index > LABEL_LEN)
         {
            _index = LABEL_LEN;
         }
         if(data.time > 0)
         {
            if(this.isRollOver && this.nowRollOverIndex == _index)
            {
               TipManager.update(DateUtil.getMSBySecond4(data.time));
            }
         }
         else
         {
            if(this.isRollOver && this.nowRollOverIndex == _index)
            {
               TipManager.hide();
            }
            if(this.nowChooseBtn == this.btnVec[_index - 1])
            {
               this.nowChooseBtn = null;
               this.btnChooseHd();
            }
            this.btnVec[_index - 1].filters = Util.disabled;
         }
      }
      
      private function outEvent(e:MouseEvent = null) : void
      {
         this.nowRollOverIndex = 0;
         this.isRollOver = false;
         TipManager.hide();
      }
      
      private function downEvent(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      public function setChoose(e:MouseEvent = null) : void
      {
         var tIndex:int = int(e.target.tabIndex);
         if(this.checkFacesByBtnIndex(tIndex))
         {
            this.setPartChoose(50000 + tIndex,e.target as Button);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(tipsStrArr[tIndex - 1],1);
         }
      }
      
      private function checkFacesByBtnIndex(index:int) : Boolean
      {
         var __index:int = 0;
         var arr:Array = null;
         if(index == 1)
         {
            if(GameUnitManager.hero.vip > 0)
            {
               return true;
            }
         }
         else
         {
            __index = index + 50000;
            for each(arr in Model_face.data)
            {
               if(arr[0] == __index && arr[1] > 0)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function setPartChoose(id:int, btn:Button) : void
      {
         var icon:Icons = null;
         if(Boolean(this.nowShowIcon))
         {
            this.nowShowIcon.hide();
         }
         else
         {
            Utils.print("nowShowIcon null");
         }
         if(!this.dicPart[id])
         {
            addChild(this.dicPart[id] = new Icons());
         }
         else
         {
            Utils.print("finished add");
         }
         icon = this.dicPart[id];
         icon.id = id;
         icon.startIndex = Model_face.startEndArr[id - 50001][0];
         icon.endIndex = Model_face.startEndArr[id - 50001][1];
         icon.selFun = this.selFun;
         icon.show();
         this.nowShowIcon = icon;
         if(Boolean(this.nowChooseBtn))
         {
            this.nowChooseBtn.filters = [];
         }
         this.nowChooseBtn = btn;
         this.nowChooseBtn.filters = Util.glowFFFFFF;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Global.control.registerCallBack(MSG_EEE,this.btnChooseStatus);
            Global.control.registerCallBack(Model_face.MSG_TIPS_FACE,this.updateTips);
         }
         else
         {
            Global.control.removeCallBack(MSG_EEE,this.btnChooseStatus);
            Global.control.removeCallBack(Model_face.MSG_TIPS_FACE,this.updateTips);
         }
      }
   }
}

