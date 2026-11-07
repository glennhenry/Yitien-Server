package com.yiTian.view.modules.activityGuide
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class Child_SpecilItem extends Sprite
   {
      
      public static var itemsIdArr:Array = [];
      
      public static var LISTNUM:int = 11;
      
      private var txtThemeOne:MyTextField;
      
      private var txtThemeTwo:MyTextField;
      
      private var txtThemeThree:MyTextField;
      
      private var container:Canvas;
      
      private var bgs:ScaleBitmap;
      
      private var _ItemVec:Vector.<Item> = new Vector.<Item>();
      
      private var _isLoaded:Boolean = false;
      
      public function Child_SpecilItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var arrs:Array = null;
         var item:Item = null;
         var parent:* = undefined;
         var temp:int = 0;
         var i:int = 0;
         var maskShape:Shape = null;
         this.bgs = ComponentUtil.getScaleBitmap("Back_TitleBule",[5,5,2,2],this,{
            "x":5,
            "y":5,
            "width":440,
            "height":30
         },Global.Img_Cdm);
         this.txtThemeOne = ComponentUtil.getTextField("参与条件",this,{
            "x":58,
            "y":9,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.txtThemeTwo = ComponentUtil.getTextField("活动返利",this,{
            "x":228,
            "y":9,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.txtThemeThree = ComponentUtil.getTextField("操作",this,{
            "x":360,
            "y":9,
            "color":16764206,
            "size":12,
            "leading":0
         });
         arrs = Data_lib.yuanbaoSS.toArray();
         var len:int = int(arrs.length);
         if(len > 3)
         {
            if(!this.container)
            {
               this.container = new Canvas(451,178);
               addChild(this.container);
               this.container.y = 33;
               temp = 0;
               maskShape = new Shape();
               maskShape.graphics.beginFill(0,0);
               maskShape.graphics.drawRect(0,38,452,168);
               maskShape.graphics.drawRect(434,0,20,40);
               maskShape.graphics.endFill();
               addChild(maskShape);
               this.container.mask = maskShape;
               this.container.scrollAutoType = ScrollAutoType.REMAIN;
            }
            parent = this.container;
         }
         else
         {
            parent = this;
            temp = 38;
         }
         i = 0;
         while(i < len)
         {
            item = new Item();
            item.x = 5;
            item.y = temp + 56 * i;
            parent.addChild(item);
            this._ItemVec.push(item);
            item.setdate(arrs[i]);
            i++;
         }
         if(Boolean(this.container))
         {
            this.container.reset();
            this.container.align();
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.UIManager;
import com.yiTian.utils.Singleton;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.Shopping.shoppingMall.ShoppingMallPan;
import flash.display.Sprite;
import flash.events.MouseEvent;

class Item extends Sprite
{
   
   private var des_txt:MyTextField;
   
   private var award_txt:MyTextField;
   
   private var sp1_btn:Button;
   
   private var tId:int;
   
   private var tPage:int;
   
   public function Item()
   {
      super();
      ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
         "x":0,
         "y":0,
         "width":430,
         "height":50
      },Global.Img_Cdm);
      this.des_txt = ComponentUtil.getTextField("屌丝指令集合",this,{
         "x":7,
         "y":10,
         "color":16772287,
         "size":12,
         "leading":0
      });
      this.award_txt = ComponentUtil.getTextField("屌丝指令集合",this,{
         "x":243,
         "y":18,
         "color":16772287,
         "size":12,
         "leading":0
      },"center");
      this.sp1_btn = ComponentUtil.getButton("我要搞基","Button_RedFour",this,{
         "x":343,
         "y":10,
         "textColor":16184781,
         "callBack":this.clickHandler
      },Global.Img_Cdm);
   }
   
   private function clickHandler(e:MouseEvent) : void
   {
      var pan:ShoppingMallPan = null;
      switch(this.sp1_btn.label)
      {
         case "商城购买":
            pan = Singleton.getInstance(ShoppingMallPan) as ShoppingMallPan;
            pan.setItemEff(this.tId,true);
            pan.openView(0,this.tPage);
            break;
         case "秘境购买":
            UIManager.special_btn.smsHandle();
      }
   }
   
   public function setdate(arr:Array) : void
   {
      var tempGrid:View_Grid = null;
      var voI:Vo_item = null;
      this.des_txt.htmlText = arr[6];
      this.award_txt.htmlText = "马上邮件返还<font color=\'#f9ff00\'>" + arr[3] + "元宝</font>";
      var tempArr:Array = ["","商城购买","秘境购买"];
      this.sp1_btn.label = tempArr[int(arr[2])];
      this.tPage = int(arr[7]);
      var award:Array = Util.splicObj(arr[1],",_") as Array;
      var b:int = 0;
      while(b < award.length)
      {
         tempGrid = new View_Grid();
         tempGrid.set_bmp_bg();
         tempGrid.set_bmp_over(true,null);
         tempGrid.set_tf_count(true,false,true);
         addChild(tempGrid);
         voI = new Vo_item();
         this.tId = award[b][1];
         voI.id = this.tId;
         voI.count = award[b][2];
         voI.Init_lib();
         tempGrid.vo = voI;
         ComponentUtil.setPropertie(tempGrid,{
            "x":b * 50 + 100,
            "y":7
         });
         b++;
      }
   }
}
