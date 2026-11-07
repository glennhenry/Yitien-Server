package com.yiTian.view.modules.tianmingjj
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_TianmingJJ;
   import com.yiTian.data.model.Model_TianmingJJ;
   import com.yiTian.data.vo.Vo_DynamicTip;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TianmingJJCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.xiaoxiaole.Effect_Strenth;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Child_TMJJ_Result extends Sprite
   {
      
      private var btmVec:Vector.<Child_imgsRoll> = new Vector.<Child_imgsRoll>();
      
      private var btmdVec:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      private var result:MyTextField;
      
      private var timeFlag:int;
      
      private var costYB:Boolean;
      
      private var changeBtn:Button;
      
      private var reslutCon:Sprite;
      
      private var wordTip:Boolean;
      
      private var continueArr:Array = [];
      
      private var lastList:Vector.<Vo_TianmingJJ>;
      
      private var shape:Shape;
      
      public function Child_TMJJ_Result()
      {
         super();
         this.initUI2();
      }
      
      private function initUI2() : void
      {
         var b:Child_imgsRoll = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":388,
            "height":214
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":39,
            "width":340,
            "height":166
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_TMGY",this,{
            "x":114,
            "y":5
         },Global.TianMingdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":35,
            "y":50,
            "width":318,
            "height":119
         },Global.TianMingdm);
         ComponentUtil.getBitmap("light_JiangLi",this,{
            "x":35,
            "y":138
         },Global.TianMingdm);
         this.btmdVec.push(ComponentUtil.getBitmapData("Icon_YiDian",Global.TianMingdm));
         this.btmdVec.push(ComponentUtil.getBitmapData("Icon_LiangDian",Global.TianMingdm));
         this.btmdVec.push(ComponentUtil.getBitmapData("Icon_SanDian",Global.TianMingdm));
         this.btmdVec.push(ComponentUtil.getBitmapData("Icon_SiDian",Global.TianMingdm));
         this.btmdVec.push(ComponentUtil.getBitmapData("Icon_WuDian",Global.TianMingdm));
         this.btmdVec.push(ComponentUtil.getBitmapData("Icon_LiuDian",Global.TianMingdm));
         ComponentUtil.getTextField("获得 ",this,{
            "x":165,
            "y":142,
            "color":16777215,
            "size":12,
            "leading":0
         },TextFieldAutoSize.CENTER);
         this.result = ComponentUtil.getTextField("天命点 ",this,{
            "x":214,
            "y":142,
            "color":16777215,
            "size":12,
            "leading":0
         },TextFieldAutoSize.CENTER);
         this.reslutCon = new Sprite();
         Effect_Strenth.setValue(0,this.reslutCon);
         this.addChild(this.reslutCon);
         this.reslutCon.x = 177;
         this.reslutCon.y = 139;
         var vo:Vo_DynamicTip = new Vo_DynamicTip();
         vo._w = 310;
         vo.info = Enum_TianmingJJ.getTip;
         TipManager.bind(this.reslutCon,vo);
         ComponentUtil.getTextField("吉星高照",this,{
            "x":160,
            "y":53,
            "color":16383744,
            "size":16,
            "leading":0,
            "bold":true
         });
         var getBtn:Button = ComponentUtil.getButton("见好就收","Button_Four",this,{
            "x":96,
            "y":174,
            "textColor":16771436
         },Global.Img_Cdm);
         this.changeBtn = ComponentUtil.getButton("逆天改命","Button_Four",this,{
            "x":224,
            "y":174,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("HW_JLM",this,{
            "x":35,
            "y":59
         },Global.TianMingdm);
         TipManager.bind(getBtn,"点击直接获得当前奖励");
         this.setTip();
         var p:Array = [{
            "x":42,
            "y":82
         },{
            "x":93,
            "y":82
         },{
            "x":144,
            "y":82
         },{
            "x":195,
            "y":82
         },{
            "x":246,
            "y":82
         },{
            "x":297,
            "y":82
         }];
         var i:int = 0;
         while(i < 6)
         {
            b = new Child_imgsRoll(this.btmdVec.concat());
            ComponentUtil.setPropertie(b,p[i]);
            this.addChild(b);
            this.btmVec.push(b);
            i++;
         }
         getBtn.callBack = this.getWard;
         this.changeBtn.callBack = this.onChange;
      }
      
      private function setBtnTime() : void
      {
         var tt:int = 0;
         var cc:Function = null;
         cc = function():void
         {
            --tt;
            if(tt == 0)
            {
               changeBtn.label = "逆天改命";
               changeBtn.enabled = changeBtn.mouseEnabled = true;
            }
            else
            {
               changeBtn.label = tt.toString();
               setTimeout(cc,1000);
            }
         };
         var _temp_1:* = this.changeBtn;
         this.changeBtn.mouseEnabled = false;
         _temp_1.enabled = false;
         tt = 1;
         this.changeBtn.label = tt.toString();
         setTimeout(cc,1000);
      }
      
      private function getWard(evt:MouseEvent) : void
      {
         var ck:Function = null;
         ck = function(box:CheckBox):void
         {
            wordTip = box.selected;
         };
         if(this.wordTip)
         {
            this.GC_getword();
            return;
         }
         View_Alert.show("<font color=\'#ffffff\'>您未摇到<font color=\'#04ff00\'>6个吉</font>，摇到6个吉可获得<font color=\'#04ff00\'>1500天命点</font>，确定要立刻获得吗?</font>",View_Alert.OK_CANCAL,this.GC_getword,null,null,null,340,"","",TextFormatAlign.LEFT,true);
         View_Alert.instance.showCheckBox = ck;
      }
      
      private function GC_getword() : void
      {
         TianmingJJCGMessage.CG_TMJJ_LQ(Enum_TianmingJJ.LQ);
         this.visible = false;
      }
      
      private function onChange(evt:MouseEvent) : void
      {
         var ck:Function;
         var cost:int = 0;
         if(this.timeFlag == 0)
         {
            this.timeFlag = setTimeout(function():void
            {
               clearTimeout(timeFlag);
               timeFlag = 0;
            },2000);
            if(this.continueArr.length == 6)
            {
               UIManager.centerBroadcast.addMsg("已经吉星高照了，不需要继续改运！");
            }
            else if(this.costYB)
            {
               if(GameUnitManager.hero.money < cost)
               {
                  UIManager.centerBroadcast.addMsg("你的元宝不够！");
               }
               else
               {
                  this.setBtnTime();
                  cost = int(Data_lib.tianmingjinjieyb[Model_TianmingJJ.currentTimes + 2]);
                  if(cost != 0)
                  {
                     UIManager.centerBroadcast.addMsg("扣除" + cost + "元宝进行改运");
                  }
                  TianmingJJCGMessage.CG_TMJJ_LQ(Enum_TianmingJJ.GY);
               }
            }
            else
            {
               cost = int(Data_lib.tianmingjinjieyb[Model_TianmingJJ.currentTimes + 2]);
               if(GameUnitManager.hero.money < cost)
               {
                  UIManager.centerBroadcast.addMsg("你的元宝不够！");
               }
               else
               {
                  ck = function(box:CheckBox):void
                  {
                     costYB = box.selected;
                  };
                  View_Alert.show("你确定花费" + cost + "元宝改变命运?",View_Alert.OK_CANCAL,function():void
                  {
                     setBtnTime();
                     if(cost != 0)
                     {
                        UIManager.centerBroadcast.addMsg("扣除" + cost + "元宝进行改运");
                     }
                     TianmingJJCGMessage.CG_TMJJ_LQ(Enum_TianmingJJ.GY);
                  },null,null,null,310,"","",TextFormatAlign.LEFT,true);
                  View_Alert.instance.showCheckBox = ck;
               }
            }
            return;
         }
      }
      
      private function setTip() : void
      {
         var str:String = null;
         var cost:int = int(Data_lib.tianmingjinjieyb[Model_TianmingJJ.currentTimes + 2]);
         str = "花费<font color=\'#04ff00\'>" + cost + "</font>元宝重新投掷筛子进行改运";
         TipManager.bind(this.changeBtn,str);
      }
      
      public function setdate() : void
      {
         var b:Child_imgsRoll = null;
         this.setTip();
         var arr:Vector.<Vo_TianmingJJ> = Model_TianmingJJ.vec;
         var i:int = 0;
         while(i < 6)
         {
            b = this.btmVec[arr[i].index];
            if(this.lastList.length == 0)
            {
               b.value = arr[i].value - 1;
            }
            else if(this.continueArr.indexOf(arr[i].index) == -1)
            {
               b.persistRollTo(this.lastList[i].value - 1,arr[i].value - 1);
            }
            if(arr[i].value == 6 && this.continueArr.indexOf(arr[i].index) == -1)
            {
               this.continueArr.push(arr[i].index);
            }
            i++;
         }
         this.lastList = Model_TianmingJJ.vec.concat();
         var arrd:Array = Model_TianmingJJ.result.split("_");
         Effect_Strenth.setValue(arrd[0],this.reslutCon);
         var len:int = String(arrd[0]).length - 2 > 0 ? int(String(arrd[0]).length - 2) : 0;
         this.result.x = 214 + len * 12;
         if(Model_TianmingJJ.isMax())
         {
            setTimeout(this.GC_getword,2000);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            this.continueArr = [];
            this.lastList = new Vector.<Vo_TianmingJJ>();
            Effect_Strenth.setValue(0,this.reslutCon);
         }
      }
   }
}

