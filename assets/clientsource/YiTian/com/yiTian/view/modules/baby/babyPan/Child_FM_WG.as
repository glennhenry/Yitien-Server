package com.yiTian.view.modules.baby.babyPan
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BabyCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.baby.babyIcon.BabyBtnBesideRole;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Child_FM_WG extends Sprite
   {
      
      private static var lBMArr:Array = [];
      
      private static var btnArr:Array = [];
      
      private static var itemIdArr:Array = [45291,45292,45293];
      
      public static var idArr:Array = [36022,36023,36024];
      
      private static var disabledArr:Array = ["36022D","36023D","36024D"];
      
      public static var wuGongVoArr:Array = ["JY_wuGong","JZ_wuGong","Thirt_wuGong"];
      
      private static var voSkillArr:Array = [];
      
      private static var isFirst:Boolean = true;
      
      private var con1:Sprite;
      
      private var con2:Sprite;
      
      public var checkBox:CheckBox;
      
      private var spriConVec:Vector.<Sprite> = new Vector.<Sprite>(3);
      
      private var bmArr:Array = [];
      
      private var txtWgMJ:Bitmap;
      
      private var viewTip:ViewT;
      
      private var type:int;
      
      private var ppArr:Array = [];
      
      public function Child_FM_WG()
      {
         super();
         this.con1 = new Sprite();
         this.con2 = new Sprite();
         addChild(this.con1);
         addChild(this.con2);
         this.init();
      }
      
      public static function updateWGBy(typeIndx:int) : void
      {
         var _id:int = int(Vo_WuGong.instance[wuGongVoArr[typeIndx]]);
         if(_id <= 0)
         {
            lBMArr[typeIndx].bitmapData = ComponentUtil.getBitmapData(disabledArr[typeIndx],Global.ZNdm);
            btnArr[typeIndx].style = "Button_ZBWG";
         }
         else
         {
            lBMArr[typeIndx].bitmapData = ComponentUtil.getBitmapData(idArr[typeIndx].toString(),Global.ZNdm);
            btnArr[typeIndx].style = "Button_XZWG";
         }
      }
      
      public static function fly_to_bag(index:int) : void
      {
         var point:Point;
         var pointBag:Point;
         var bm:Bitmap = null;
         var cBm:Bitmap = null;
         bm = Pool.getObject(Bitmap);
         cBm = lBMArr[index];
         bm.bitmapData = cBm.bitmapData;
         Global.stage.addChild(bm);
         point = cBm.parent.localToGlobal(new Point(cBm.x,cBm.y));
         ComponentUtil.setPropertie(bm,{
            "x":point.x,
            "y":point.y
         });
         pointBag = UIManager.mainMenu.getbagPoint();
         Tween.to(bm,500,{
            "x":[bm.x,pointBag.x],
            "y":[bm.y,pointBag.y]
         },function(b:Bitmap):void
         {
            if(Boolean(b.parent))
            {
               b.parent.removeChild(b);
            }
            Pool.saveObject(b);
         },null,Tween.SIN);
      }
      
      private function init() : void
      {
         var j:int = 0;
         var item:Sprite = null;
         var bn:Button = null;
         var conSpri:Sprite = null;
         var b:Bitmap = null;
         var mas:Shape = null;
         var bmd:BitmapData = null;
         var bb:Bitmap = null;
         var btn:Button = null;
         var voS:Vo_Skill = null;
         ComponentUtil.getBitmap("light_FMCZ",this.con1,{
            "x":0,
            "y":0
         },Global.ZNdm);
         this.checkBox = ComponentUtil.getCheckBox("附魔出战","CheckBox01",this.con1,{
            "x":75,
            "y":6,
            "color":16772287
         },Global.Img_Cdm);
         var bbBmd:BitmapData = ComponentUtil.getBitmapData("Back_WGMJ",Global.ZNdm);
         j = 0;
         while(j < 2)
         {
            conSpri = new Sprite();
            conSpri.tabIndex = j * 2;
            b = Pool.getObject(Bitmap);
            mas = ComponentUtil.getShape(70,93);
            bmd = new BitmapData(70,73,true,0);
            bmd.copyPixels(bbBmd,new Rectangle(120 * j,0,70,73),new Point(0,0),null,null,true);
            bb = Pool.getObject(Bitmap);
            b.bitmapData = bmd;
            ComponentUtil.setPropertie(mas,{
               "x":17 + 120 * j,
               "y":-43
            });
            ComponentUtil.setPropertie(bb,{
               "x":17.5 - j * 6,
               "y":27
            });
            ComponentUtil.setPropertie(conSpri,{
               "x":87,
               "y":-43
            });
            conSpri.addChild(b);
            conSpri.addChild(bb);
            btn = ComponentUtil.getButton("","Button_ZBWG",conSpri,{
               "x":47.6 - j * 6,
               "y":57,
               "visible":false,
               "tabIndex":j * 2
            },Global.ZNdm);
            btnArr.push(btn);
            this.con2.addChild(conSpri);
            this.con2.addChild(mas);
            conSpri.mask = mas;
            this.bmArr.push(conSpri);
            lBMArr.push(bb);
            voSkillArr.push(new Vo_Skill(36022 + 2 * j));
            j++;
         }
         var midS:Sprite = new Sprite();
         midS.tabIndex = 1;
         var _bd:BitmapData = new BitmapData(50,73,true,0);
         var _bm:Bitmap = new Bitmap();
         _bd.copyPixels(bbBmd,new Rectangle(70,0,50,73),new Point(0,0),null,null,true);
         _bm.bitmapData = _bd;
         ComponentUtil.setPropertie(midS,{
            "x":87,
            "y":-43
         });
         midS.addChild(_bm);
         this.con2.addChild(midS);
         this.bmArr.splice(1,0,midS);
         var bM:Bitmap = Pool.getObject(Bitmap);
         lBMArr.splice(1,0,bM);
         ComponentUtil.setPropertie(bM,{
            "x":4.4,
            "y":27.2
         });
         midS.addChild(bM);
         this.con2.addChild(midS);
         var _btn:Button = ComponentUtil.getButton("","Button_ZBWG",midS,{
            "x":36,
            "y":57,
            "visible":false,
            "tabIndex":1
         },Global.ZNdm);
         btnArr.splice(1,0,_btn);
         voSkillArr.splice(1,0,new Vo_Skill(36023));
         this.txtWgMJ = ComponentUtil.getBitmap("Text_WGMJ",this.con2,{
            "x":82,
            "y":-38
         },Global.ZNdm);
         this.viewTip = new ViewT();
         this.con2.addChild(this.viewTip);
         this.viewTip.visible = false;
         this.viewTip.setProperty({
            "x":117,
            "y":27
         });
         for each(item in this.bmArr)
         {
            item.addEventListener(MouseEvent.MOUSE_OVER,this.over);
            item.addEventListener(MouseEvent.MOUSE_OUT,this.out);
            voS = voSkillArr[item.tabIndex];
         }
         for each(bn in btnArr)
         {
            bn.addEventListener(MouseEvent.CLICK,this.click);
         }
         this.checkBox.clickFun = this.checkBoxEvent;
         Global.control.registerCallBack(BabyBtnBesideRole.BABYPAN_MSG_BACK,this.update_wuGong);
      }
      
      private function updateItemId() : void
      {
         var count:int = 0;
         var handleOfCount:Function = function(cnt:int, index:int):void
         {
            trace(Vo_WuGong.instance[wuGongVoArr[index]].toString());
            if(cnt <= 0 && Vo_WuGong.instance[wuGongVoArr[index]] <= 0)
            {
               btnArr[index].enabled = false;
               Utils.remove_up_down_move(btnArr[index],57);
            }
            else
            {
               btnArr[index].enabled = true;
               Utils.up_down_move(btnArr[index],3,57);
            }
         };
         var i:int = 0;
         while(i < 3)
         {
            count = CommandManager.get_bag_count(itemIdArr[i]);
            handleOfCount(count,i);
            i++;
         }
      }
      
      private function update_wuGong() : void
      {
         var i:int = 0;
         while(i < 3)
         {
            updateWGBy(i);
            i++;
         }
         this.updateItemId();
      }
      
      private function over(e:MouseEvent) : void
      {
         var _index:int = 0;
         if(e.target is Button)
         {
            _index = int(e.target.parent.tabIndex);
         }
         else
         {
            _index = int(e.target.tabIndex);
         }
         btnArr[_index].visible = true;
         var voSk:Vo_Skill = voSkillArr[_index] as Vo_Skill;
         this.viewTip.update(HtmlUtil.font(HtmlUtil.bold(voSk.str_name),"#f9ff00") + "\n" + voSk.effect_description);
      }
      
      private function out(e:MouseEvent) : void
      {
         var _index:int = 0;
         if(e.target is Button)
         {
            _index = int(e.target.parent.tabIndex);
         }
         else
         {
            _index = int(e.target.tabIndex);
         }
         btnArr[_index].visible = false;
         this.viewTip.hide();
      }
      
      private function click(e:MouseEvent) : void
      {
         var type:int = int(e.target.tabIndex);
         var _id:int = int(Vo_WuGong.instance[wuGongVoArr[type]]);
         if(_id > 0)
         {
            BabyCGMessage.CG_UPLOAD_WUGONG(idArr[type]);
         }
         else
         {
            BabyCGMessage.CG_BABY_ADD_WUGONG(idArr[type]);
         }
      }
      
      private function moveEff() : void
      {
         Tween.to(this.bmArr[0],300,{"x":[87,17]},null,null,Tween.SIN);
         Tween.to(this.bmArr[2],300,{"x":[87,137]},null,null,Tween.SIN);
      }
      
      public function checkBoxEvent(e:CheckBox) : void
      {
         BabyCGMessage.CG_ISFUMO(int(e.selected));
      }
      
      public function update(index:uint) : void
      {
         if(index == 0)
         {
            this.con1.visible = true;
            this.con2.visible = false;
         }
         else
         {
            if(isFirst)
            {
               this.moveEff();
               isFirst = false;
            }
            this.con1.visible = false;
            this.con2.visible = true;
         }
      }
   }
}

import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import flash.display.Sprite;

class ViewT extends Sprite
{
   
   private var border:ScaleBitmap;
   
   private var tf:MyTextField;
   
   private var _oldW:Number = -1;
   
   private var _oldH:Number = -1;
   
   private var obj:Object;
   
   public function ViewT()
   {
      super();
      this.border = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
         "x":0,
         "y":0,
         "width":87,
         "height":95
      },Global.Img_Cdm);
      this.tf = ComponentUtil.getTextField("",this,{
         "x":3,
         "y":3,
         "align":"left",
         "leading":3,
         "wordWrap":true,
         "multiline":true,
         "realWidth":245,
         "textColor":16777215
      });
   }
   
   public function setProperty(obj:Object) : void
   {
      this.obj = obj;
   }
   
   public function update(str:String) : void
   {
      this.tf.htmlText = str;
      var newWidth:Number = this.tf.textWidth + 14;
      var newHeight:Number = this.tf.textHeight + 14;
      if(this._oldW != newWidth || this._oldH != newHeight)
      {
         this._oldW = this.border.width = newWidth;
         this._oldH = this.border.height = newHeight;
      }
      if(!visible)
      {
         visible = true;
      }
      x = this.obj.x - this.border.width / 2;
      y = this.obj.y - this.border.height - 50;
   }
   
   public function hide() : void
   {
      visible = false;
   }
}
