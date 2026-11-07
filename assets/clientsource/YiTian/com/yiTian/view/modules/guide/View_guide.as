package com.yiTian.view.modules.guide
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HumanCGMessage;
   import com.yiTian.net.message.cg.QuestCGMessage;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.MainUIBase;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class View_guide extends MainUIBase
   {
      
      private static const GRID_LEN:int = 4;
      
      private static var isHZTuiJian:Boolean = false;
      
      public static var dataA:Array = [];
      
      private var tip1:String;
      
      private var tip2:String;
      
      private var bg:Bitmap;
      
      private var goBtn:Button;
      
      private var tf1:MyTextField;
      
      private var tf2:MyTextField;
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      private var qb_888:Bitmap;
      
      public function View_guide()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.tip1 = LangConfig.getWord("50023",5);
         this.tip2 = LangConfig.getWord("50024",5);
         this.bg = ComponentUtil.getBitmap("guideBg",this,null,Global.guideMM);
         this.tf1 = ComponentUtil.getTextField(this.tip1,this,{
            "color":16776960,
            "x":216,
            "y":153,
            "realWidth":330,
            "wordWrap":true
         });
         this.tf2 = ComponentUtil.getTextField(this.tip2,this,{
            "color":8644096,
            "x":220,
            "y":200
         });
         this.goBtn = ComponentUtil.getButton("","Button_Go",this,{
            "x":450,
            "y":237
         },Global.guideBtn);
         this.resetPosition();
         Global.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.stageClick);
      }
      
      public function initSource(data:Array) : void
      {
         this.tf1.text = "";
         this.tf2.text = "";
         dataA = data;
         isHZTuiJian = true;
         if(!Global.XSYinDaodm)
         {
            SingleLoader.add("lang/ch/XSYinDao.swf",function(info:Object):void
            {
               Global.XSYinDaodm = info.applicationDomain;
               initB();
            });
         }
      }
      
      public function initB() : void
      {
         var i:int;
         var _data:Array = null;
         var grid:View_Grid = null;
         var type:int = 0;
         var id:int = 0;
         var count:int = 0;
         var vo:Vo_item = null;
         var ss:String = "";
         if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            ss = "亲！您来自黄钻每日礼包推荐，可领取688元宝礼包";
         }
         else if(Global.pf == Enum_SPStr.QQGAME)
         {
            ss = "亲！您来自大厅推荐用户，可领取688元宝礼包";
         }
         ComponentUtil.getTextField(ss,this,{
            "x":232,
            "y":151,
            "color":16776960,
            "size":12,
            "leading":0
         });
         i = 0;
         while(i < GRID_LEN)
         {
            _data = dataA[i];
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count(true,false,true);
            addChild(grid);
            type = int(_data[0]);
            id = int(_data[1]);
            count = int(_data[2]);
            if(type == 1)
            {
               vo = new Vo_item();
               vo.id = id;
               vo.Init_lib();
               vo.count = count;
            }
            grid.x = 248 + i * 70;
            grid.y = 187;
            grid.vo = vo;
            this.gridVec.push(grid);
            i++;
         }
         this.goBtn.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            YelloDiaCGMessage.CG_TUIJIAN_LIBAO_SEND();
         });
      }
      
      public function addQB888() : void
      {
         if(!this.qb_888)
         {
            this.qb_888 = ComponentUtil.getBitmap("qb_888",this,null,Global.Img_Cdm);
         }
         ComponentUtil.setPropertie(this.qb_888,{
            "x":this.goBtn.x - this.qb_888.width / 2 + 2,
            "y":this.goBtn.y - this.qb_888.height / 2 + 2
         });
      }
      
      private function stageClick(e:MouseEvent) : void
      {
         Global.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.stageClick);
         if(Boolean(this.bg) && Boolean(this.bg.bitmapData))
         {
            this.bg = null;
         }
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         Global.guideBtn = null;
         GameUnitManager.hero.autoMove(51001);
         Global.isFirstPlay = false;
         HumanCGMessage.CG_FIRST_PLAY();
         if(isHZTuiJian)
         {
            YelloDiaCGMessage.CG_TUIJIAN_LIBAO_SEND();
         }
         else
         {
            QuestCGMessage.CG_GET_NEWER_GIFT();
         }
         UIManager.questTraceView.showMainQGuide();
      }
      
      public function getAwards() : void
      {
         var g:View_Grid = null;
         var cnt:int = 0;
         var j:int = 0;
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            g = this.gridVec[i];
            cnt = g.count;
            j = 0;
            while(j < cnt)
            {
               ComboTweenStep.toBag(g,0,0,null,"bsToBag");
               j++;
            }
            i++;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 560) / 2;
         y = (Global.stage.stageHeight - 288) / 2;
      }
   }
}

