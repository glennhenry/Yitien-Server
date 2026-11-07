package com.yiTian.view.modules.treeDownCL
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.treeDownCL.lUtils.Child_txtItem;
   import com.yiTian.view.modules.treeDownCL.lUtils.DescripPan;
   import com.yiTian.view.modules.treeDownCL.lUtils.MoveRoundPan;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class TreeOutsidePan extends Panel123
   {
      
      private static var isInit:Boolean = false;
      
      private static var maxLen:int = 3;
      
      private var desCripItem:Item;
      
      private var moveDescriItem:DescripPan;
      
      private var btnVec:Vector.<Button> = new Vector.<Button>();
      
      private var _type:int;
      
      private var pageCount:int = 0;
      
      public function TreeOutsidePan()
      {
         super();
      }
      
      public static function get instance() : TreeOutsidePan
      {
         return Singleton.getInstance(TreeOutsidePan);
      }
      
      override protected function initUI2() : void
      {
         var btn:Button = null;
         if(isInit)
         {
            return;
         }
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":568,
            "height":390
         },Global.Img_Cdm);
         move = new Rectangle(0,0,563,38);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":24,
            "y":40,
            "width":520,
            "height":340
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":29,
            "y":45,
            "width":510,
            "height":330
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_Img",this,{
            "x":34,
            "y":50
         },Global.DaShu_Imgsdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":534,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         initDynamicView();
         this.btnVec.push(ComponentUtil.getButton("","Button_Left",this,{
            "x":91 + 10,
            "y":175 - 4,
            "textColor":16184781,
            "tabIndex":1
         },Global.DaShu_Imgsdm),ComponentUtil.getButton("","Button_Right",this,{
            "x":453 - 10,
            "y":175 - 4,
            "textColor":16184781,
            "tabIndex":2
         },Global.DaShu_Imgsdm));
         for each(btn in this.btnVec)
         {
            btn.addEventListener(MouseEvent.CLICK,this.changed);
         }
         ComponentUtil.getBitmap("Title_DaShu",this,{
            "x":204,
            "y":5
         },Global.DaShu_Imgsdm);
         this.moveDescriItem = new DescripPan(296,154);
         addChild(this.moveDescriItem);
         this.moveDescriItem.setMask({
            "x":141,
            "y":118,
            "width":290,
            "height":154
         });
         this.desCripItem = new Item();
         addChild(this.desCripItem);
         ComponentUtil.setPropertie(this.desCripItem,{
            "x":182,
            "y":306
         });
         isInit = true;
         this.update(this._type);
      }
      
      public function update(type:int) : void
      {
         if(!isInit)
         {
            this._type = type;
            if(!Global.DaShu_Imgsdm)
            {
               SingleLoader.add("lang/ch/DaShu_Imgs.swf",function(info:Object):void
               {
                  Global.DaShu_Imgsdm = info.applicationDomain;
                  initUI2();
               });
            }
            else
            {
               this.initUI2();
            }
            return;
         }
         if(!visible)
         {
            this.visible = true;
         }
         this.desCripItem.update(type);
      }
      
      private function changed(e:MouseEvent) : void
      {
         switch(e.target.tabIndex)
         {
            case 1:
               --this.pageCount;
               this.pageCount = this.pageCount < 1 ? 1 : this.pageCount;
               this.moveDescriItem.addItem(Child_txtItem.instance,MoveRoundPan.LEFT_MOVE,this.getPageDt(this.pageCount));
               break;
            case 2:
               ++this.pageCount;
               this.pageCount = this.pageCount > maxLen ? maxLen : this.pageCount;
               this.moveDescriItem.addItem(Child_txtItem.instance,MoveRoundPan.RIGHT_MOVE,this.getPageDt(this.pageCount));
         }
         this.btnHd(this.pageCount);
      }
      
      private function btnHd(page:int) : void
      {
         this.btnVec[0].enabled = page != 1;
         this.btnVec[1].enabled = page != maxLen;
      }
      
      private function getPageDt(page:int) : String
      {
         var _dic:DictionaryTabel = Data_lib.DSCLdescrip;
         maxLen = _dic.getLength();
         return _dic[page][0];
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.btnVec[1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            pop();
         }
         else
         {
            this.pageCount = 0;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 563) / 2;
         y = (Global.stage.stageHeight - 390) / 2;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.model.Model_team;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.SceneConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.TreeDownCLCGMessage;
import com.yiTian.view.modules.treeDownCL.lUtils.MoveObj;
import flash.display.Sprite;

class Item extends Sprite
{
   
   private var tf:MyTextField;
   
   private var btn:Button;
   
   public function Item()
   {
      super();
      this.tf = ComponentUtil.getTextField("每天的12:45和21:45我们相聚大树下面乘凉",this,{
         "x":-24,
         "y":0,
         "color":16776960,
         "size":14,
         "leading":0
      });
      this.btn = ComponentUtil.getButton("进入场景","Button_Enter",this,{
         "x":44,
         "y":-8,
         "textColor":16184781
      },Global.DaShu_Imgsdm);
      this.btn.callBack = function():void
      {
         if(Boolean(Model_team.isTeam[GameUnitManager.hero.id]))
         {
            UIManager.centerBroadcast.addMsg("组队状态不能进入");
            return;
         }
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg("请先退出副本");
            return;
         }
         if(GameUnitManager.hero.level < 35)
         {
            UIManager.centerBroadcast.addMsg("等级不够");
            return;
         }
         TreeDownCLCGMessage.CG_ENTER_TREEMAP();
      };
   }
   
   public function update(type:int) : void
   {
      if(type == 1)
      {
         this.tf.visible = true;
         this.btn.visible = false;
         MoveObj.addMoveTf(this.tf,310,49,MoveObj.LEFT,true);
      }
      else if(type == 2)
      {
         MoveObj.stop(this.tf);
         this.tf.visible = false;
         this.btn.visible = true;
      }
   }
}
