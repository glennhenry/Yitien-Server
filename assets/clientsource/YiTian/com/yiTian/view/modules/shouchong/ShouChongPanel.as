package com.yiTian.view.modules.shouchong
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ShouChongCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class ShouChongPanel extends Panel
   {
      
      private var bm:Bitmap;
      
      private var btn:Button;
      
      private var data:Array = [[96518,1],[46314,5],[49001,5],[46260,5],[46012,5],[46062,5],[43002,2],[43012,2]];
      
      private var vecGrid:Vector.<View_Grid>;
      
      private const STR1:String = "resource/image/shouchong/shouChong.png";
      
      private const STR2:String = "resource/image/shouchong/linqujiangli.png";
      
      private var curStr:String;
      
      private var shouChongBtn:Sprite;
      
      private var scBM:Bitmap;
      
      private var cleaIdArr:Array;
      
      private var isFirstOpen:Boolean = true;
      
      public function ShouChongPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var g:View_Grid = null;
         var v:Vo_item = null;
         var e:Vo_equip = null;
         var back:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":584,
            "height":381
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":536,
            "height":330
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":550,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.bm = new Bitmap();
         addChild(this.bm);
         this.bm.x = 34;
         this.bm.y = 50;
         ComponentUtil.getTextField(LangConfig.getWord("10616",1),this,{
            "x":149,
            "y":150,
            "color":16383744,
            "size":17,
            "bold":true
         });
         i = 8;
         this.vecGrid = new Vector.<View_Grid>(i,true);
         while(Boolean(i--))
         {
            g = new View_Grid();
            g.type = Enum_type_grid.NO_DRAG;
            g.set_tf_count(true,true,true);
            g.set_bmp_bg();
            g.set_bmp_select();
            g.set_bmp_over();
            addChild(g);
            g.isAutoLoad = false;
            g.x = 80 + 59 * (i % 4);
            g.y = 272 + 45 * Math.floor(i / 4);
            if(Boolean(i))
            {
               v = new Vo_item();
               v.id = this.data[i][0];
               v.Init_lib();
               g.vo = v;
            }
            else
            {
               e = new Vo_equip();
               e.id = this.data[i][0];
               e.Init_lib();
               g.vo = e;
            }
            this.vecGrid[i] = g;
         }
      }
      
      protected function onClick(e:MouseEvent) : void
      {
         UIManager.yuanBaoXiang.visible = true;
      }
      
      public function get SCBtn() : Sprite
      {
         return this.shouChongBtn;
      }
      
      public function showShouChongBtn(type:int) : void
      {
         if(!this.shouChongBtn)
         {
            this.shouChongBtn = new Sprite();
            this.shouChongBtn.graphics.beginFill(16777215,0);
            this.shouChongBtn.graphics.drawRect(0,0,50,50);
            this.shouChongBtn.graphics.endFill();
            this.scBM = new Bitmap();
            this.shouChongBtn.addChild(this.scBM);
            this.shouChongBtn.buttonMode = true;
            this.shouChongBtn.addEventListener(MouseEvent.CLICK,this.shouChongOnClick);
            ComponentUtil.setPropertie(this.shouChongBtn,{
               "x":-8,
               "y":-9
            });
         }
         UIManager.mainUiBtnContainer.addBTN(this.shouChongBtn);
         if(Boolean(type))
         {
            this.curStr = this.STR2;
            Utils.getLoadBitmap(this.STR2,this.scBM);
         }
         else
         {
            this.curStr = this.STR1;
            Utils.getLoadBitmap(this.STR1,this.scBM);
            this.scBM.x = (65 - 54) / 2;
            this.scBM.y = (70 - 54) / 2;
         }
      }
      
      public function removeShouChongBtn() : void
      {
         UIManager.mainUiBtnContainer.removeBTN(this.shouChongBtn);
      }
      
      public function playEff() : void
      {
         var sid:int = 0;
         var item:Vo_equip = null;
         var p:Point = UIManager.mainUiBtnContainer.localToGlobal(new Point(this.shouChongBtn.x,this.shouChongBtn.y));
         this.cleaIdArr = [];
         var i:uint = 0;
         while(i < 8)
         {
            if(Boolean(i))
            {
               sid = int(setTimeout(this.timeOutFunc,100 * i,{
                  "index":i,
                  "point":p
               }));
               this.cleaIdArr[i] = sid;
            }
            else
            {
               item = new Vo_equip();
               item.id = this.data[i][0];
               item.Init_lib();
               Tween.gridToBagBezierFuncDef(item,-1,p.x,p.y);
            }
            i++;
         }
      }
      
      private function timeOutFunc(o:Object) : void
      {
         var vo:Vo_item = null;
         vo = new Vo_item();
         vo.id = this.data[o.index][0];
         vo.Init_lib();
         Tween.gridToBagBezierFuncDef(vo,-1,o.point.x,o.point.y);
         clearTimeout(this.cleaIdArr[o.index]);
         if(o.index == this.data.length - 1)
         {
            this.removeShouChongBtn();
         }
      }
      
      protected function shouChongOnClick(e:MouseEvent) : void
      {
         if(this.curStr == this.STR1)
         {
            WuXingMter.getPan(ShouChongNew,function(pan:ShouChongNew):void
            {
               pan.visible = true;
            });
         }
         else if(this.curStr == this.STR2)
         {
            ShouChongCGMessage.CG_SHOUCHONG_AWARD();
         }
      }
      
      public function setGridLoad() : void
      {
         var i:int = 8;
         while(Boolean(i--))
         {
            this.vecGrid[i].isAutoLoad = true;
            this.vecGrid[i].beginLoad();
            this.vecGrid[i].count = this.data[i][1];
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.setGridLoad();
               this.isFirstOpen = false;
               Utils.loadTitle("lang/ch/ShouChong_Imgs.swf","ShouChong_Img",this.bm);
               Utils.loadTitle("lang/ch/ShouChong_Imgs.swf","Title_ChongZhi",new Bitmap(),{
                  "x":192,
                  "y":5
               },this);
               if(!this.btn)
               {
                  if(!Global.ShouChong_Imgsdm)
                  {
                     SingleLoader.add("lang/ch/ShouChong_Imgs.swf",function(info:Object):void
                     {
                        Global.ShouChong_Imgsdm = info.applicationDomain;
                        showBtn();
                     });
                  }
               }
            }
         }
      }
      
      private function showBtn() : void
      {
         this.btn = ComponentUtil.getButton(HtmlUtil.font(HtmlUtil.bold(LangConfig.getWord("10617",1)),"#ffffff",15),"Button_CongZhi",this,{
            "x":142,
            "y":209,
            "textColor":16184781
         },Global.ShouChong_Imgsdm);
         this.btn.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

