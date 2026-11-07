package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.roleHead.BuffterVO;
   import com.yiTian.view.modules.roleHead.BuffterView;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormatAlign;
   import flashx.textLayout.formats.TextAlign;
   
   public class PetHeadPanel extends Panel
   {
      
      private static const PETNAMES:Array = [LangConfig.getWord("60249",6),LangConfig.getWord("60250",6),LangConfig.getWord("60251",6),LangConfig.getWord("60252",6)];
      
      private const WIDTH:int = 84;
      
      private const HEIGHT:int = 7;
      
      private var petHead:Bitmap;
      
      private var hpBM:Bitmap;
      
      private var hpMask:Shape;
      
      private var hpTip:Sprite;
      
      private var jyBM:Bitmap;
      
      private var jyMask:Shape;
      
      private var jypTip:Sprite;
      
      private var nameTxt:MyTextField;
      
      private var levelTxt:MyTextField;
      
      private var jiaQuXue:Button;
      
      private var buffterVec:Vector.<BuffterView>;
      
      private var curUrl:String;
      
      private const bufferXY:Point = new Point(65,38);
      
      public function PetHeadPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject;
         var setMask:DisplayObject;
         bAutoRemove = false;
         back = ComponentUtil.getBitmap("Back_PetHead",this,null,Global.Scenedm);
         this.nameTxt = ComponentUtil.getTextField("",this,{
            "x":48,
            "y":0,
            "color":9760866,
            "realWidth":86,
            "align":TextAlign.CENTER
         });
         this.levelTxt = ComponentUtil.getTextField("000",this,{
            "x":40.5,
            "y":37,
            "color":14013822
         });
         this.levelTxt.size = 11;
         this.levelTxt.realWidth = 20;
         this.levelTxt.align = TextFormatAlign.CENTER;
         this.hpBM = ComponentUtil.getBitmap("Pet_Head_HP",this,{
            "x":48,
            "y":18
         },Global.Scenedm);
         this.hpMask = new Shape();
         this.draw(this.hpMask,this.WIDTH);
         addChild(this.hpMask);
         this.hpMask.x = this.hpBM.x;
         this.hpMask.y = this.hpBM.y;
         this.hpBM.mask = this.hpMask;
         this.hpTip = this.getSprite(this.WIDTH,this.HEIGHT);
         this.hpTip.x = this.hpBM.x;
         this.hpTip.y = this.hpBM.y;
         addChild(this.hpTip);
         this.jyBM = ComponentUtil.getBitmap("Pet_Head_JY",this,{
            "x":48,
            "y":28
         },Global.Scenedm);
         this.jyMask = new Shape();
         this.draw(this.jyMask,this.WIDTH);
         addChild(this.jyMask);
         this.jyMask.x = this.jyBM.x;
         this.jyMask.y = this.jyBM.y;
         this.jyBM.mask = this.jyMask;
         this.jypTip = this.getSprite(this.WIDTH,this.HEIGHT);
         this.jypTip.x = this.jyBM.x;
         this.jypTip.y = this.jyBM.y;
         addChild(this.jypTip);
         this.petHead = new Bitmap();
         this.petHead.cacheAsBitmap = true;
         this.petHead.x = 8;
         this.petHead.y = 7;
         addChild(this.petHead);
         setMask = ComponentUtil.getDisplayObject("Pet_Head_Mask",this,{
            "x":this.petHead.x,
            "y":this.petHead.y
         },ComponentUtil.domain);
         setMask.cacheAsBitmap = true;
         this.petHead.mask = setMask;
         (setMask as Sprite).buttonMode = true;
         setMask.addEventListener(MouseEvent.CLICK,this.headClickHandler);
         this.jiaQuXue = ComponentUtil.getButton("","Button_Jia",this,{
            "x":135,
            "y":15
         },Global.Img_Cdm);
         this.jiaQuXue.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
         {
            UIManager.petPanel.jiaQiXueClick();
         });
         this.buffterVec = new Vector.<BuffterView>();
      }
      
      private function draw(shape:Shape, width:int) : void
      {
         shape.graphics.beginFill(0,1);
         shape.graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         shape.graphics.endFill();
      }
      
      protected function headClickHandler(event:Event) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.KFBZ_BATTLE || SceneConfig.getSceneType() == SceneConfig.CROSS_CAMP_BATTLE)
         {
            return;
         }
         UIManager.petPanel.visible = !UIManager.petPanel.visible;
         PetCGMessage.CG_PET_DANQI_ICON();
      }
      
      private function getSprite(w:Number, h:Number) : Sprite
      {
         var temp:Sprite = new Sprite();
         var g:Graphics = temp.graphics;
         g.beginFill(16777215,0);
         g.drawRect(0,0,w,h);
         g.endFill();
         return temp;
      }
      
      public function update() : void
      {
         var w:int = 0;
         var petVO:PetVO = UIManager.petPanel.petVO;
         if(Boolean(petVO))
         {
            if(Global.pf == "qqgame" || Global.pf == "3366")
            {
               if(petVO.img == 20907)
               {
                  if(PETNAMES.indexOf(petVO.name) != -1)
                  {
                     petVO.name = LangConfig.getWord("60250",6);
                  }
               }
            }
            else if(Global.pf == "union-10029-24")
            {
               Utils.print("爱玩");
            }
            else if(Global.pf == "3366")
            {
               Utils.print("3366");
            }
            else if(Global.pf == "qplus")
            {
               if(petVO.img == 20908)
               {
                  if(PETNAMES.indexOf(petVO.name) != -1)
                  {
                     petVO.name = LangConfig.getWord("60252",6);
                  }
               }
            }
            else if(Global.pf == "box")
            {
               if(petVO.img == 20906)
               {
                  petVO.img = 20901;
                  petVO.name = LangConfig.getWord("60249",6);
               }
            }
            else if(petVO.img == 20906)
            {
               if(PETNAMES.indexOf(petVO.name) != -1)
               {
                  petVO.name = LangConfig.getWord("60251",6);
               }
            }
            if(petVO.img == 20901)
            {
               if(PETNAMES.indexOf(petVO.name) != -1)
               {
                  petVO.name = LangConfig.getWord("60249",6);
               }
            }
            this.nameTxt.text = petVO.name;
            this.levelTxt.text = petVO.level.toString();
            this.curUrl = "resource/image/icon/" + petVO.img + "_34.jpg";
            MassLoader.add(this.curUrl,this.onComlete);
            w = petVO.curQiXue < petVO.maxQiXue ? int(petVO.curQiXue / petVO.maxQiXue * this.WIDTH) : this.WIDTH;
            this.draw(this.hpMask,w);
            this.hpMask.width = w;
            w = Number(petVO.curJiangYan) < Number(petVO.maxJiangYan) ? int(Number(petVO.curJiangYan) / Number(petVO.maxJiangYan) * this.WIDTH) : this.WIDTH;
            this.draw(this.jyMask,w);
            this.jyMask.width = w;
            TipManager.bind(this.hpTip,LangConfig.getWord("10082",1) + petVO.curQiXue + "/" + petVO.maxQiXue);
            TipManager.bind(this.jypTip,LangConfig.getWord("10083",1) + petVO.curJiangYan + "/" + petVO.maxJiangYan);
         }
      }
      
      private function onComlete(info:Object) : void
      {
         Util.bmdPool[info.url] = (info.content as Bitmap).bitmapData;
         if(this.curUrl == info.url)
         {
            this.petHead.bitmapData = (info.content as Bitmap).bitmapData;
         }
      }
      
      public function showBuffter() : void
      {
         var buffVOVec:Vector.<Vo_Buffer>;
         if(!UIManager.petPanel.petVO)
         {
            return;
         }
         buffVOVec = BuffterVO.petBuffVOVec;
         this.buffterVec.forEach(function(item:BuffterView, index:int, vec:Vector.<BuffterView>):void
         {
            item.visible = false;
            item.dispose();
         });
         if(buffVOVec.length > 0)
         {
            buffVOVec.forEach(function(item:Vo_Buffer, index:int, vec:Vector.<Vo_Buffer>):void
            {
               try
               {
                  buffterVec[index].vo = item;
                  buffterVec[index].visible = true;
               }
               catch(e:Error)
               {
                  buffterVec[index] = new BuffterView();
                  buffterVec[index].vo = item;
                  addChild(buffterVec[index]);
                  buffterVec[index].x = bufferXY.x + (buffterVec[index].width + 10) * index;
                  buffterVec[index].y = bufferXY.y;
               }
            });
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.hpBM.bitmapData)
            {
               Utils.getLoadBitmap("resource/image/pet/Pet_HP.png",this.hpBM);
            }
            if(!this.jyBM.bitmapData)
            {
               Utils.getLoadBitmap("resource/image/pet/Pet_JY.png",this.jyBM);
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = 250;
         y = BoatManager.headCY;
      }
   }
}

