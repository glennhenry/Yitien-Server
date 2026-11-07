package com.yiTian.view.modules.pet.petD
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.cast.CastEffect;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flashx.textLayout.formats.TextAlign;
   
   public class PetZiZhiItem extends Sprite
   {
      
      private static var LoadSource:Boolean = false;
      
      private var gridsVec:Vector.<View_Grid> = new Vector.<View_Grid>(1);
      
      private var tfVecsPinZhi:Vector.<MyTextField> = new Vector.<MyTextField>(2);
      
      private var tfVecsValueTop:Vector.<MyTextField> = new Vector.<MyTextField>(2);
      
      private var ratetf:MyTextField;
      
      private var maskSp:Shape;
      
      private var progressBm:Bitmap;
      
      private var beyondBtn:Button;
      
      private var bmBind:Bitmap;
      
      private var downContainer:Sprite;
      
      private var upContainer:Sprite;
      
      private var tuPoLvl:int;
      
      private var numsArr:Array = [15,20,30,60,80];
      
      private var tf_fullPinzhi:MyTextField;
      
      private var tf_fullVal:MyTextField;
      
      public function PetZiZhiItem()
      {
         super();
         if(!LoadSource)
         {
            this.initSource();
         }
      }
      
      public function initB() : void
      {
         var i:int;
         var spri:Sprite;
         var g:View_Grid = null;
         var vo:Vo_item = null;
         if(LoadSource)
         {
            return;
         }
         this.downContainer = new Sprite();
         this.upContainer = new Sprite();
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":5,
            "y":49,
            "width":235,
            "height":118
         },Global.Img_Cdm);
         i = 0;
         addChild(this.downContainer);
         addChild(this.upContainer);
         i = 0;
         while(i < this.gridsVec.length)
         {
            g = new View_Grid();
            g.set_bmp_bg();
            g.set_bmp_over(true,null);
            g.set_tf_count(false,false,false);
            vo = new Vo_item();
            vo.id = 44715;
            vo.Init_lib();
            g.vo = vo;
            this.downContainer.addChild(g);
            ComponentUtil.setPropertie(g,{
               "x":98 + i * 60,
               "y":173
            });
            this.gridsVec[i] = g;
            i++;
         }
         this.beyondBtn = ComponentUtil.getButton("突破","Button_Orange",this.downContainer,{
            "x":87,
            "y":223,
            "textColor":16184781
         },Global.Img_Cdm);
         this.beyondBtn.callBack = function():void
         {
            PetCGMessage.CG_PET_TYPE_SEND(tuPoLvl);
         };
         ComponentUtil.getBitmap("ProgressBack_02",this.downContainer,{
            "x":10,
            "y":255
         },Global.Pet_Imgsdm);
         this.progressBm = ComponentUtil.getBitmap("Progress_02",this.downContainer,{
            "x":12,
            "y":257
         },Global.Pet_Imgsdm);
         this.maskSp = new Shape();
         this.maskSp.graphics.beginFill(0,0);
         this.maskSp.graphics.drawRect(0,0,221,10);
         this.maskSp.graphics.endFill();
         addChild(this.maskSp);
         this.progressBm.mask = this.maskSp;
         ComponentUtil.setPropertie(this.maskSp,{
            "x":12,
            "y":257
         });
         spri = new Sprite();
         spri.graphics.beginFill(0,0);
         spri.graphics.drawRect(0,0,221,10);
         spri.graphics.endFill();
         ComponentUtil.setPropertie(spri,{
            "x":12,
            "y":257
         });
         this.downContainer.addChild(spri);
         TipManager.bind(spri,HtmlUtil.font("宠物突破的成功率初始为" + "<font color=\'#ff7700\'>" + "5%" + "</font>" + "（最低）,\n每次突破失败增加" + "<font color=\'#ff7700\'>" + "2%" + "</font>" + "成功率。\n注：成功率每天降低" + "<font color=\'#ff7700\'>" + "2%" + "</font>","#ffffff"));
         ComponentUtil.getBitmap("TitleBack",this,{
            "x":5,
            "y":58
         },Global.Pet_Imgsdm);
         ComponentUtil.getBitmap("TitleBack",this,{
            "x":5,
            "y":108
         },Global.Pet_Imgsdm);
         ComponentUtil.getTextField("资质品质",this,{
            "x":97,
            "y":58,
            "color":16383744,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("资质上限",this,{
            "x":97,
            "y":108,
            "color":16383744,
            "size":12,
            "leading":0
         });
         i = 0;
         while(i < 2)
         {
            this.tfVecsPinZhi[i] = ComponentUtil.getTextField("品质",this.upContainer,{
               "x":70 + 84 * i,
               "y":85,
               "color":327424,
               "size":12,
               "leading":0
            });
            i++;
         }
         ComponentUtil.getBitmap("JianTou_02",this.upContainer,{
            "x":101,
            "y":87
         },Global.Pet_Imgsdm);
         ComponentUtil.getTextField("突破材料：",this.downContainer,{
            "x":18,
            "y":173,
            "color":13424242,
            "size":12,
            "leading":0
         });
         i = 0;
         while(i < 2)
         {
            this.tfVecsValueTop[i] = ComponentUtil.getTextField("000",this.upContainer,{
               "x":70 + 84 * i,
               "y":134,
               "color":16764206,
               "size":12,
               "leading":0
            });
            i++;
         }
         ComponentUtil.getBitmap("JianTou_02",this.upContainer,{
            "x":101,
            "y":136
         },Global.Pet_Imgsdm);
         this.ratetf = ComponentUtil.getTextField("00%",this.downContainer,{
            "x":12,
            "y":252,
            "color":16383744,
            "size":12,
            "leading":0,
            "realWidth":200,
            "align":TextAlign.CENTER
         });
         LoadSource = true;
      }
      
      public function initSource() : void
      {
         if(!Global.Pet_Imgsdm)
         {
            SingleLoader.add("lang/ch/Pet_Imgs.swf",function(info:Object):void
            {
               Global.Pet_Imgsdm = info.applicationDomain;
               initB();
            });
         }
         else
         {
            this.initB();
         }
      }
      
      public function update(lvl:int) : void
      {
         var tf1:MyTextField = null;
         var tf2:MyTextField = null;
         var _arr1:Array = null;
         var _arr2:Array = null;
         this.tuPoLvl = lvl;
         var i:int = 0;
         while(i < 2)
         {
            tf1 = this.tfVecsPinZhi[i];
            tf2 = this.tfVecsValueTop[i];
            _arr1 = Model_pet.typeChangedDesArr[lvl - 1];
            _arr2 = Model_pet.typeChangedValArr[lvl - 1];
            tf1.htmlText = _arr1[i];
            tf2.htmlText = _arr2[i];
            i++;
         }
         var len:int = int(this.numsArr[lvl - 1]);
         var count:int = CommandManager.get_bag_count(44715);
         var g:View_Grid = this.gridsVec[0];
         var _count:int = CommandManager.get_bag_count(44715);
         g.set_tf_info("\n" + _count + "/" + len,g.numChildren - 1);
         if(count >= len)
         {
            g.filters = [];
         }
         else
         {
            g.filters = Util.disabled;
         }
         if(UIManager.petPanel.petVO.ziZhi == 350)
         {
            this.downContainer.visible = false;
            this.upContainer.visible = false;
            if(!this.tf_fullPinzhi)
            {
               this.tf_fullPinzhi = ComponentUtil.getTextField("玄品",this,{
                  "x":101,
                  "y":83,
                  "size":14,
                  "realWidth":44,
                  "color":16646144,
                  "align":TextAlign.CENTER
               });
            }
            if(!this.tf_fullVal)
            {
               this.tf_fullVal = ComponentUtil.getTextField("350",this,{
                  "x":101,
                  "y":133,
                  "size":14,
                  "realWidth":44,
                  "color":16646144,
                  "align":TextAlign.CENTER
               });
            }
         }
         else
         {
            this.downContainer.visible = true;
            this.upContainer.visible = true;
         }
         if(UIManager.petPanel.petVO.level < 80)
         {
            this.beyondBtn.enabled = false;
            this.beyondBtn.label = "80级可突破";
         }
         else
         {
            this.beyondBtn.enabled = true;
            this.beyondBtn.label = "突破";
         }
      }
      
      public function upRate(rate:int) : void
      {
         this.ratetf.text = "成功率：" + rate + "%";
         var wid:Number = 221 * (rate / 100);
         this.maskSp.width = wid;
      }
      
      public function bagUpdate() : void
      {
         var len:int = int(this.numsArr[this.tuPoLvl - 1]);
         var count:int = CommandManager.get_bag_count(44715);
         var g:View_Grid = this.gridsVec[0];
         g.set_tf_info("\n" + count + "/" + len,g.numChildren - 1);
         if(count >= len)
         {
            g.filters = [];
         }
         else
         {
            g.filters = Util.disabled;
         }
      }
      
      public function updateSucce(result:int) : void
      {
         var eff1:Effect = null;
         var g:View_Grid = this.gridsVec[0];
         if(result == 3)
         {
            EffectManager.addEffect("35066",this,800,g.x + 30,g.y);
            CastEffect.getFailEffect("tupoF",new Point(g.x - 40,g.y - 20),this);
            eff1 = EffectManager.addEffect("35062",this,500,g.x + 30,g.y + 30);
            Tween.to(eff1,400,{
               "px":[eff1.px,this.maskSp.x + this.maskSp.width],
               "py":[eff1.py,this.maskSp.y + this.maskSp.height]
            },function():void
            {
               CastEffect.endHanlde();
            });
         }
         else if(result == 4)
         {
            CastEffect.getEffect("tupoS",new Point(347,267),UIManager.petPanel);
         }
      }
   }
}

