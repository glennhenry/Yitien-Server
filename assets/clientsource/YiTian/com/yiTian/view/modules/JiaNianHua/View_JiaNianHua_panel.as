package com.yiTian.view.modules.JiaNianHua
{
   import com.ui.controls.Button;
   import com.ui.controls.MaskProgressBar2;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JiaNianHuaCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.mainUIBtnContainer.MainUIBtn;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_JiaNianHua_panel extends Panel123
   {
      
      private static var _instance:View_JiaNianHua_panel;
      
      public var icon:MainUIBtn;
      
      protected var ChongZhiBtn:Button;
      
      public var getBtn:Button;
      
      protected var listItemArr:Array = [];
      
      protected var progress:MaskProgressBar2;
      
      protected var progressTxt:MyTextField;
      
      protected var prizeGridArr:Array = [];
      
      public function View_JiaNianHua_panel()
      {
         super();
         regResource("lang/ch/JNH.swf","JNHdm");
      }
      
      public static function get instance() : View_JiaNianHua_panel
      {
         if(!_instance)
         {
            _instance = new View_JiaNianHua_panel();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var prizeTotalArr:Array;
         var j:* = undefined;
         var i:int = 0;
         var prizeArr:Array = null;
         var grid:View_Grid = null;
         var vo:Vo_valuable = null;
         var eff:Effect = null;
         var item:ListItem = null;
         var FanLi1:int = 0;
         var FanLi2:int = 0;
         var FanLi3:int = 0;
         useRotation3D = true;
         move = new Rectangle(0,0,738,30);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":738,
            "height":521
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":688,
            "height":471
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":703,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":664,
            "height":200
         },Global.JNHdm);
         ComponentUtil.getBitmap("Back_JHSFL",this,{
            "x":37,
            "y":285
         },Global.JNHdm);
         ComponentUtil.getBitmap("Title_JNH",this,{
            "x":(738 - 160) / 2,
            "y":5
         },Global.JNHdm);
         ComponentUtil.getBitmap("Text_JBDJ",this,{
            "x":53,
            "y":146
         },Global.JNHdm);
         ComponentUtil.getBitmap("Back_JZYB",this,{
            "x":49,
            "y":154
         },Global.JNHdm);
         ComponentUtil.getBitmap("Back_XYYTD",this,{
            "x":44,
            "y":59
         },Global.JNHdm);
         ComponentUtil.getDisplayObject("DateMC",this,{
            "x":64,
            "y":79
         },Global.JNHdm);
         ComponentUtil.getBitmap("Text_JHSFL",this,{
            "x":44,
            "y":252
         },Global.JNHdm);
         ComponentUtil.getBitmap("Text_CZYB",this,{
            "x":191,
            "y":178
         },Global.JNHdm);
         prizeTotalArr = Data_lib.carnivalFeedback[1][1].split(",");
         for(j in prizeTotalArr)
         {
            prizeArr = prizeTotalArr[j].split("_");
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over();
            grid.set_tf_count();
            addChild(grid);
            this.prizeGridArr.push(grid);
            grid.x = 191 + j * 62;
            grid.y = 205;
            if(prizeArr[0] == 1)
            {
               vo = new Vo_item();
            }
            else if(prizeArr[0] == 2)
            {
               vo = new Vo_equip();
            }
            vo.id = prizeArr[1];
            vo.count = prizeArr[2];
            vo.bBind = true;
            vo.Init_lib();
            vo.bBind = true;
            grid.vo = vo;
            if(j < 3)
            {
               eff = EffectManager.addEffect("35180",grid,1000,42,42,true);
               eff.scaleX = 0.5;
               eff.scaleY = 0.5;
            }
         }
         this.getBtn = ComponentUtil.getButton("","Button_JNHJL",this,{
            "x":549,
            "y":206,
            "textColor":16771436
         },Global.JNHdm);
         this.getBtn.callBack = function():void
         {
            JiaNianHuaCGMessage.CG_JiaNianHua_GET();
         };
         this.getBtn.enabled = false;
         ComponentUtil.getTextField("充值额度",this,{
            "x":74,
            "y":288,
            "color":14013809,
            "size":12,
            "leading":0
         });
         this.progress = new MaskProgressBar2(ComponentUtil.getScaleBitmap("HuiKuiProgress",[6,7,42,2],null,{
            "x":63,
            "y":479,
            "width":498,
            "height":16
         },Global.JNHdm),ComponentUtil.getScaleBitmap("HuiKuiProgress_Back",[32,15,61,4],null,{
            "x":37,
            "y":470,
            "width":550,
            "height":34
         },Global.JNHdm));
         addChild(this.progress);
         this.progressTxt = ComponentUtil.getTextField("",this,{
            "x":315,
            "y":478,
            "color":16755712,
            "size":12,
            "leading":0
         },"center");
         this.ChongZhiBtn = ComponentUtil.getButton("","Button_Recharge",this,{
            "x":591,
            "y":463,
            "textColor":16771436
         },Global.JNHdm);
         i = 0;
         while(i < 3)
         {
            ComponentUtil.getTextField(Data_lib.carnivalFeedback[i + 1][4],this,{
               "x":251 + i * 181,
               "y":288,
               "color":16755712,
               "size":12,
               "leading":0
            },"center");
            item = new ListItem();
            addChild(item);
            item.x = 45;
            item.y = 319 + i * 50;
            this.listItemArr.push(item);
            item.setTitleTxt(Data_lib.carnivalFeedback[i + 1][5]);
            FanLi1 = int(Data_lib.carnivalFeedback[i + 1][6].split("_")[2]);
            FanLi2 = int(Data_lib.carnivalFeedback[i + 1][7].split("_")[2]);
            FanLi3 = int(Data_lib.carnivalFeedback[i + 1][8].split("_")[2]);
            item.setFanLi(FanLi1,FanLi2,FanLi3);
            i++;
         }
         this.ChongZhiBtn.callBack = function():void
         {
            UIManager.yuanBaoXiang.visible = true;
         };
      }
      
      public function showIcon(result:int, time:int) : void
      {
         if(!this.icon)
         {
            this.icon = new MainUIBtn("resource/image/JiaNianHua/icon.png");
            this.icon.addEventListener(MouseEvent.CLICK,this.onClickIcon);
         }
         if(result == 0)
         {
            if(Boolean(this.icon))
            {
               UIManager.mainUiBtnContainer.removeBTN(this.icon);
               this.icon.effectEnd();
            }
            this.visible = false;
         }
         else
         {
            if(!this.icon)
            {
               this.icon = new MainUIBtn("resource/image/JiaNianHua/icon.png");
               this.icon.addEventListener(MouseEvent.CLICK,this.onClickIcon);
            }
            UIManager.mainUiBtnContainer.addBTN(this.icon);
            if(result == 2)
            {
               this.icon.effectBegin();
            }
            this.icon.setCountDown(time,true);
         }
      }
      
      public function setData(money:int, btnStatus:int) : void
      {
         var i:int = 0;
         while(i < 3)
         {
            this.listItemArr[i].setChongZhiTxt(money);
            i++;
         }
         var level:int = 1;
         while(money >= Data_lib.carnivalFeedback[level][5])
         {
            level++;
         }
         if(level > 3)
         {
            level = 3;
            this.progress.persent = 1;
         }
         else
         {
            this.progress.persent = money / Data_lib.carnivalFeedback[level][5];
         }
         this.progressTxt.text = money + "/" + Data_lib.carnivalFeedback[level][5];
         if(btnStatus == 1)
         {
            this.getBtn.enabled = true;
            this.icon.effectBegin();
         }
         else
         {
            this.getBtn.enabled = false;
            this.icon.effectEnd();
         }
      }
      
      public function flyToBag() : void
      {
         var i:* = undefined;
         for(i in this.prizeGridArr)
         {
            ComboTweenStep.toBag(this.prizeGridArr[i]);
         }
      }
      
      protected function onClickIcon(e:MouseEvent) : void
      {
         JiaNianHuaCGMessage.CG_JiaNianHua_OPEN();
      }
   }
}

