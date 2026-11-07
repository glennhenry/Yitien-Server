package com.yiTian.view.modules.boatChall
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BoatPH extends Panel123
   {
      
      private static var suoXiaoEd:Boolean = false;
      
      private static var isSuoXiaoRunning:Boolean = false;
      
      private var itemVec:Vector.<Item> = new Vector.<Item>(11);
      
      private var btnSuoXiao:Button;
      
      private var miniCon:Sprite;
      
      private var container:Sprite;
      
      public function BoatPH()
      {
         super();
         regResource("lang/ch/FWLZ.swf","FWLZdm");
      }
      
      public static function get instance() : BoatPH
      {
         return Singleton.getInstance(BoatPH);
      }
      
      override protected function initUI2() : void
      {
         var item:Item = null;
         var gap:int = 0;
         this.container = new Sprite();
         addChild(this.container);
         ComponentUtil.getBitmap("Back_LZPH",this.container,{
            "x":0,
            "y":0
         },Global.FWLZdm);
         this.miniCon = new Sprite();
         addChild(this.miniCon);
         ComponentUtil.setPropertie(this.miniCon,{
            "x":222 + 10,
            "y":4 + 10
         });
         this.btnSuoXiao = ComponentUtil.getButton("","Button_NumMax",this.miniCon,{
            "x":-10,
            "y":-10,
            "textColor":16771436
         },Global.Img_Cdm);
         this.btnSuoXiao.callBack = this.cliHd;
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            item = new Item();
            this.itemVec[i] = item;
            item.visible = false;
            this.container.addChild(item);
            gap = i < 4 ? 23 : 24;
            ComponentUtil.setPropertie(item,{
               "x":14,
               "y":58 + gap * i
            });
            i++;
         }
         ComponentUtil.getBitmap("Text_PMXX",this.container,{
            "x":27,
            "y":4
         },Global.FWLZdm);
         ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this.container,{
            "x":6,
            "y":30,
            "width":233,
            "height":27
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_LZFWQ",this.container,{
            "x":136,
            "y":34
         },Global.FWLZdm);
         ComponentUtil.getBitmap("Text_LZLZ",this.container,{
            "x":67,
            "y":34
         },Global.FWLZdm);
         ComponentUtil.getBitmap("Text_LZPM",this.container,{
            "x":10,
            "y":34
         },Global.FWLZdm);
         ComponentUtil.getBitmap("Text_LZSJ",this.container,{
            "x":200,
            "y":34
         },Global.FWLZdm);
      }
      
      public function show() : void
      {
         visible = visible || true;
      }
      
      public function hide() : void
      {
         visible = visible && false;
      }
      
      public function updata(data:Array) : void
      {
         var index:int = 0;
         var bangName:String = null;
         var quHao:int = 0;
         var time:int = 0;
         var item:Item = null;
         this.reset();
         data.length = data.length > 10 ? 10 : data.length;
         var i:int = 0;
         while(i < data.length)
         {
            index = int(data[i][0]);
            bangName = data[i][1];
            quHao = int(data[i][2]);
            time = int(data[i][3]);
            item = this.itemVec[i];
            item.visible = true;
            item.update(index,bangName,quHao,time);
            i++;
         }
         this.show();
      }
      
      private function reset() : void
      {
         var item:Item = null;
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            item = this.itemVec[i];
            item.visible = false;
            i++;
         }
      }
      
      private function cliHd(e:MouseEvent = null) : void
      {
         var obj:Object = null;
         if(isSuoXiaoRunning)
         {
            return;
         }
         isSuoXiaoRunning = true;
         if(suoXiaoEd)
         {
            obj = {"rotation":[180,0]};
            Tween.to(this.container,200,{
               "scaleX":[0,1],
               "scaleY":[0,1],
               "x":[this.container.x,this.container.x - 227]
            });
         }
         else
         {
            obj = {"rotation":[0,180]};
            Tween.to(this.container,200,{
               "scaleX":[1,0],
               "scaleY":[1,0],
               "x":[this.container.x,this.container.x + 227]
            });
         }
         Tween.to(this.miniCon,200,obj,function():void
         {
            isSuoXiaoRunning = false;
         });
         suoXiaoEd = !suoXiaoEd;
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - 246;
         y = (Global.stage.stageHeight - 245) / 2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.utils.DateUtil;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

class Item extends Sprite
{
   
   private var tfIndex:MyTextField;
   
   private var bangNameTf:MyTextField;
   
   private var quhaoTf:MyTextField;
   
   private var timeTF:MyTextField;
   
   public function Item()
   {
      super();
      this.init();
   }
   
   private function init() : void
   {
      this.tfIndex = ComponentUtil.getTextField("2",this,{
         "x":0,
         "y":0,
         "color":14662240,
         "size":12,
         "leading":0
      });
      this.bangNameTf = ComponentUtil.getTextField("帮派名六个字",this,{
         "x":29,
         "y":0,
         "color":16184781,
         "size":12,
         "leading":0,
         "realWidth":82
      },TextFieldAutoSize.CENTER);
      this.quhaoTf = ComponentUtil.getTextField("400服",this,{
         "x":118,
         "y":0,
         "color":14662240,
         "size":12,
         "leading":0,
         "realWidth":56
      },TextFieldAutoSize.CENTER);
      this.timeTF = ComponentUtil.getTextField("00:00",this,{
         "x":181,
         "y":0,
         "color":11532607,
         "size":12,
         "leading":0
      });
   }
   
   public function update(index:int, bangName:String, quHao:int, time:int) : void
   {
      this.tfIndex.htmlText = index.toString();
      this.bangNameTf.htmlText = bangName;
      this.quhaoTf.htmlText = quHao.toString() + "服";
      this.timeTF.htmlText = DateUtil.getMSBySecond3(time);
   }
}
