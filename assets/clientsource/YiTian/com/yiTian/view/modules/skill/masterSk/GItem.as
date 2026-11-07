package com.yiTian.view.modules.skill.masterSk
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_bar_swap;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MasterSkillCGMessage;
   import com.yiTian.net.message.cg.SkillCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.skill.Model_skill;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class GItem extends Sprite
   {
      
      public static var lightItem:GItem;
      
      private static var lsTime:int;
      
      private var bg:Bitmap;
      
      private var icon:Bitmap;
      
      private var iconContainer:Sprite;
      
      public var isBig:Boolean = false;
      
      public var vo:Vo_Skill;
      
      private var tfCount:MyTextField;
      
      public var type:int;
      
      public var index:int;
      
      private var _bm:Bitmap;
      
      private var lightSprite:Sprite;
      
      public function GItem(bigIcon:Boolean, index:int = 0, canClick:Boolean = false)
      {
         super();
         this.bg = new Bitmap();
         addChild(this.bg);
         this.index = index;
         if(index > 0 && index < 10)
         {
            this.tfCount = ComponentUtil.getTextField(index.toString(),this);
         }
         this.iconContainer = new Sprite();
         this.iconContainer.graphics.beginFill(0,0);
         this.iconContainer.graphics.drawRect(0,0,34,34);
         this.iconContainer.graphics.endFill();
         addChild(this.iconContainer);
         this.icon = new Bitmap();
         this.iconContainer.addChild(this.icon);
         this.isBig = bigIcon;
         this.iconContainer.addEventListener(MouseEvent.ROLL_OVER,this.over);
         this.iconContainer.addEventListener(MouseEvent.ROLL_OUT,this.out);
         if(canClick)
         {
            this.iconContainer.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
            {
               var now:int = getTimer();
               if(now - lsTime < 2000)
               {
                  UIManager.centerBroadcast.addMsg("操作太频繁了",1);
                  return;
               }
               lsTime = now;
               Global.control.registerCallBack("masterSkillChose",choose);
               MasterSkillCGMessage.CG_MASTERSKILL_CHOOSE(vo.id);
            });
         }
         addEventListener(MouseEvent.MOUSE_UP,this.onUp);
      }
      
      private function choose() : void
      {
         if(Boolean(lightItem))
         {
            lightItem.lighting = false;
         }
         this.lighting = true;
         lightItem = this;
         UIManager.centerBroadcast.addMsg("您选择了" + HtmlUtil.font(this.vo.str_name,"#ff7700",14) + "神功进行战斗!",1);
         Global.control.removeCallBack("masterSkillChose",this.choose);
      }
      
      private function downMove(e:MouseEvent) : void
      {
         if(!this.icon.bitmapData)
         {
            return;
         }
         Model_skill.dragTarget(this.icon,this.index);
      }
      
      private function onUp(e:MouseEvent) : void
      {
         var dragItem1:View_Grid = UIManager.dragObj.grid;
         var dragItem2:Object = Model_skill.dragObj;
         var iiIndex:int = this.index;
         var ttIndex:int = 0;
         if(iiIndex > 10)
         {
            return;
         }
         if(UIManager.isDrag || Boolean(dragItem2 && int(dragItem2.data) < 10) && Boolean(int(dragItem2.data) > 0))
         {
            if(UIManager.isDrag)
            {
               ttIndex = dragItem1.index;
            }
            else
            {
               ttIndex = int(dragItem2.data);
            }
            SkillCGMessage.CG_SET_BAR(Enum_bar_swap.BAR_TO_BAR,ttIndex,iiIndex);
         }
         else if(Boolean(dragItem2) && int(dragItem2.data) > 10)
         {
            ttIndex = int(dragItem2.data);
            SkillCGMessage.CG_SET_BAR(Enum_bar_swap.SKILL_TO_BAR,ttIndex,iiIndex);
         }
      }
      
      public function setfilters(arr:Array) : void
      {
         this.icon.filters = arr;
      }
      
      public function initBg(bmd:BitmapData) : void
      {
         this.bg.bitmapData = bmd;
         if(Boolean(this.tfCount))
         {
            ComponentUtil.setPropertie(this.tfCount,{
               "x":(this.bg.x + this.bg.width - this.tfCount.width) / 2,
               "y":(this.bg.y + this.bg.height - this.tfCount.height) / 2
            });
         }
      }
      
      private function over(e:MouseEvent) : void
      {
         var point:Point = null;
         var gapY:Number = NaN;
         TipManager.update(this.vo,Enum_type_grid.MASTER_SKILL);
         point = localToGlobal(new Point(this.icon.x,this.icon.y));
         gapY = point.y + TipManager.view_tip.height - Global.stage.stageHeight;
         var gapX:Number = point.x + TipManager.view_tip.width - Global.stage.stageWidth;
         TipManager.view_tip.x = point.x + this.icon.width;
         TipManager.view_tip.y = point.y + this.icon.height;
         if(gapY > 0)
         {
            TipManager.view_tip.y = point.y + this.icon.height - gapY - 50;
         }
         if(gapX > 0)
         {
            TipManager.view_tip.x = point.x - TipManager.view_tip.width;
         }
      }
      
      private function out(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function update(_vo:Vo_grid) : void
      {
         if(Boolean(_vo) && Boolean((_vo as Vo_Skill).skill_type == 3) && this.index >= 17)
         {
            Global.control.registerCallBack((_vo as Vo_Skill).str_name,this.update);
         }
         this.vo = _vo as Vo_Skill;
         if(this.vo == null)
         {
            this.icon.bitmapData = null;
            return;
         }
         var addBigStr:String = this.isBig ? "60/" : "/";
         var str:String = "resource/image/icon" + addBigStr + this.vo.str_icon + ".png";
         Utils.getLoadBitmap(str,this.icon);
         this.resize();
         if(this.vo.skill_type != 3 && this.vo.skill_type != 4 && this.vo.current_grade > 0)
         {
            if(!this.iconContainer.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
               this.iconContainer.addEventListener(MouseEvent.MOUSE_DOWN,this.downMove);
            }
         }
         if(this.vo.current_grade == 0)
         {
            this.setfilters(Util.disabled);
         }
         else
         {
            this.setfilters([]);
         }
      }
      
      public function set iconBm(value:BitmapData) : void
      {
         this.icon.bitmapData = value;
         this.resize();
      }
      
      private function resize() : void
      {
         var wid:Number = this.icon.width;
         var hei:Number = this.icon.height;
         if(Boolean(this.vo) && Boolean(this.vo.skill_type == 3) && wid != 50)
         {
            wid = 50;
            hei = 50;
         }
         else if(Boolean(this.vo) && Boolean(this.vo.skill_type != 3) && wid != 34)
         {
            wid = 34;
            hei = 34;
         }
         ComponentUtil.setPropertie(this.icon,{
            "x":(this.bg.width - wid) / 2,
            "y":(this.bg.height - hei) / 2
         });
      }
      
      public function set lighting(value:Boolean) : void
      {
         if(value)
         {
            if(!this.lightSprite)
            {
               this.getlightSprite();
            }
            this.lightSprite.visible = true;
            if(!this._bm)
            {
               this._bm = new Bitmap();
               this._bm.bitmapData = ComponentUtil.getBitmapData("Icon_SYZ",Global.SMJNdm);
               ComponentUtil.setPropertie(this._bm,{
                  "x":-14,
                  "y":-11
               });
               addChild(this._bm);
            }
            this._bm.visible = true;
            Tween.to(this._bm,100,{
               "scaleX":[5,1],
               "scaleY":[5,1],
               "x":[-14 - 2 * this._bm.width,-14],
               "y":[-11 - 2 * this._bm.height,-11]
            });
         }
         else
         {
            if(Boolean(this.lightSprite))
            {
               this.lightSprite.visible = false;
            }
            if(Boolean(this._bm))
            {
               this._bm.visible = false;
            }
         }
      }
      
      private function getlightSprite() : void
      {
         this.lightSprite = new Sprite();
         this.lightSprite.graphics.beginFill(0,0.8);
         this.lightSprite.graphics.drawRect(0,0,53,53);
         this.lightSprite.graphics.endFill();
         addChildAt(this.lightSprite,0);
         ComponentUtil.setPropertie(this.lightSprite,{
            "x":3,
            "y":3
         });
         this.lightSprite.filters = Util.glowFFFF00;
      }
   }
}

