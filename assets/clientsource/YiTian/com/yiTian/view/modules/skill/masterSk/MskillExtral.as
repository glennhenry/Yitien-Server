package com.yiTian.view.modules.skill.masterSk
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class MskillExtral extends Sprite
   {
      
      private var tfSW:MyTextField;
      
      private var tfExp:MyTextField;
      
      private var line:Shape;
      
      private var lineGra:Graphics;
      
      private var len:int;
      
      public function MskillExtral()
      {
         super();
         this.init();
      }
      
      public static function get instance() : MskillExtral
      {
         return Singleton.getInstance(MskillExtral);
      }
      
      private function init() : void
      {
         this.line = new Shape();
         addChild(this.line);
         this.tfSW = ComponentUtil.getTextField("",this);
         this.tfExp = ComponentUtil.getTextField("",this);
         this.lineGra = this.line.graphics;
         this.lineGra.lineStyle(3,16383744);
      }
      
      public function showExt(_parent:DisplayObjectContainer, voSkill:Vo_Skill, startPoint:Point, type:int) : void
      {
         if(!_parent.contains(this))
         {
            _parent.addChild(this);
         }
         this.changedData(voSkill);
         this.update(type,startPoint);
         this.visible = visible || true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Global.control.registerCallBack("dataChanged_ofMskill",this.changedData);
         }
         else
         {
            Global.control.removeCallBack("dataChanged_ofMskill",this.changedData);
         }
      }
      
      private function changedData(_voSk:Vo_Skill) : void
      {
         var sw:int = 0;
         var exp:Number = NaN;
         var requiredSS:String = Data_lib.skill[_voSk.id][Vo_Skill.REQUIRED_PROP];
         if(requiredSS.indexOf(",") != -1)
         {
            exp = Number(requiredSS.split(",")[0].split("_")[1]);
            sw = int(requiredSS.split(",")[1].split("_")[1]);
         }
         this.data = {
            "sw":sw,
            "exp":exp
         };
      }
      
      public function hideExt() : void
      {
         this.visible = false;
      }
      
      public function set data(info:Object) : void
      {
         this.tfSW.htmlText = "声望 " + HtmlUtil.font(info.sw.toString(),"#33cc00");
         this.tfExp.htmlText = "经验 " + HtmlUtil.font(info.exp / 100000000 + "亿","#33cc00");
         this.len = Math.max(this.tfSW.textWidth,this.tfExp.textWidth);
      }
      
      public function update(type:int, startPoint:Point) : void
      {
         this.lineGra.clear();
         this.lineGra.lineStyle(2,16383744);
         this.lineGra.moveTo(startPoint.x,startPoint.y);
         if(type == 1)
         {
            this.lineGra.lineTo(startPoint.x - 30,startPoint.y);
            this.lineGra.lineTo(startPoint.x - 30,startPoint.y - 20);
            this.lineGra.lineTo(startPoint.x - 30 - this.len,startPoint.y - 20);
            ComponentUtil.setPropertie(this.tfSW,{
               "x":startPoint.x - 30 - this.len - 10,
               "y":startPoint.y - 40
            });
            ComponentUtil.setPropertie(this.tfExp,{
               "x":startPoint.x - 30 - this.len - 10,
               "y":startPoint.y - 18
            });
         }
         else
         {
            this.lineGra.lineTo(startPoint.x + 30,startPoint.y);
            this.lineGra.lineTo(startPoint.x + 30,startPoint.y - 20);
            this.lineGra.lineTo(startPoint.x + 30 + this.len,startPoint.y - 20);
            ComponentUtil.setPropertie(this.tfSW,{
               "x":startPoint.x + 30 + 3,
               "y":startPoint.y - 40
            });
            ComponentUtil.setPropertie(this.tfExp,{
               "x":startPoint.x + 30 + 3,
               "y":startPoint.y - 18
            });
         }
      }
   }
}

