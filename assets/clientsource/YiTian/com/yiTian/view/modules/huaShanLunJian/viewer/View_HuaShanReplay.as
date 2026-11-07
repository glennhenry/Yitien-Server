package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import Layout.HGroup;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Pool;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_HuaShanReplay extends Panel
   {
      
      private var itemArr:Array;
      
      private var hGroup:HGroup;
      
      private var tf_roleName1:MyTextField;
      
      private var tf_score:MyTextField;
      
      private var tf_roleName2:MyTextField;
      
      private var _jie:int;
      
      private var _bangType2:int;
      
      private var _lun:int;
      
      public function View_HuaShanReplay()
      {
         super();
         this.initB();
         bindParent = GameScene.uiLayer;
      }
      
      private function initB() : void
      {
         this.itemArr = [];
         this.hGroup = new HGroup(0,80,100,100,30,0);
         var bg:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":365,
            "height":290
         },Global.Img_Cdm);
         move = new Rectangle(0,0,bg.width,38);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":317,
            "height":240
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":45,
            "width":307,
            "height":193
         },Global.Img_Cdm);
         ComponentUtil.getButton(LangConfig.getWord("29087",2),"Button_Orange",this,{
            "x":147,
            "y":246,
            "textColor":16184781,
            "callBack":this.btnCloseClickHd
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":31,
            "y":47,
            "width":303,
            "height":25
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Cross_zhanbao",this,{
            "x":102,
            "y":5
         },Global.kuafuzhan_Imgsdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],null,{
            "x":32,
            "y":95,
            "width":300,
            "height":2
         },Global.Img_Cdm);
         this.tf_roleName1 = ComponentUtil.getTextField("",this,{
            "x":92,
            "y":50,
            "color":15763456,
            "autoSize":TextFieldAutoSize.CENTER,
            "bold":true
         });
         this.tf_score = ComponentUtil.getTextField("",this,{
            "x":180,
            "y":50,
            "autoSize":TextFieldAutoSize.CENTER,
            "bold":true
         });
         this.tf_roleName2 = ComponentUtil.getTextField("",this,{
            "x":269,
            "y":50,
            "color":15763456,
            "autoSize":TextFieldAutoSize.CENTER,
            "bold":true
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":bg.width - 30,
            "y":5
         },Global.Img_Cdm);
         super.initDynamicView();
      }
      
      public function update(jie:int, bangType2:int, lun:int, chang:int, data:Object) : void
      {
         var dd:int = 0;
         var item:ReplayItem = null;
         this.clearAll();
         this._jie = jie;
         this._bangType2 = bangType2;
         this._lun = lun;
         var role1Info:Array = data[0];
         var role2Info:Array = data[1];
         var bInfo:int = int(data[2]);
         this.tf_score.text = HuaShanUtil.getScore(bInfo);
         this.tf_roleName1.text = Model_heFu.repNameByHero(role1Info[Enum_HuaShan.CONT_ROLENAME] + ".S" + role1Info[Enum_HuaShan.CONT_SERVNAME]);
         this.tf_roleName2.text = Model_heFu.repNameByHero(role2Info[Enum_HuaShan.CONT_ROLENAME] + ".S" + role2Info[Enum_HuaShan.CONT_SERVNAME]);
         var bArr:Array = [];
         while(bInfo > 0)
         {
            dd = bInfo % 10;
            bInfo = int(bInfo / 10);
            bArr.push(dd);
         }
         var i:int = 0;
         while(i < bArr.length)
         {
            item = Pool.getObject(ReplayItem);
            this.itemArr.push(item);
            item.index = i + 1;
            item.update(jie,bangType2,lun,chang,[role1Info,role2Info,bArr[i]]);
            this.hGroup.appendItem(item);
            addChild(item);
            i += 1;
         }
         this.hGroup.align();
      }
      
      private function clearAll() : void
      {
         var item:ReplayItem = null;
         for each(item in this.itemArr)
         {
            Pool.saveObject(item);
            removeChild(item);
         }
         this.hGroup.clearItem();
         this.itemArr.splice(0);
      }
      
      private function btnCloseClickHd(event:MouseEvent) : void
      {
         visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.utils.Util;
import com.yiTian.Global;
import com.yiTian.data.model.Model_heFu;
import com.yiTian.manager.LangConfig;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.utils.Utils;
import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
import flash.display.Sprite;
import flash.events.TextEvent;
import flash.text.TextFieldAutoSize;

class ReplayItem extends Sprite
{
   
   private var tf_title:MyTextField;
   
   private var tf_playerName:MyTextField;
   
   private var tf_result:MyTextField;
   
   private var tf_check:MyTextField;
   
   private var _jie:int;
   
   private var _bangType2:int;
   
   private var _lun:int;
   
   private var _index:int;
   
   private var _chang:int;
   
   private var _ju:int;
   
   public function ReplayItem()
   {
      super();
      this.tf_title = ComponentUtil.getTextField("",this,{
         "x":65,
         "autoSize":TextFieldAutoSize.CENTER
      });
      this.tf_playerName = ComponentUtil.getTextField("",this,{
         "x":157,
         "autoSize":TextFieldAutoSize.CENTER
      });
      this.tf_result = ComponentUtil.getTextField(LangConfig.getWord("29344",2),this,{
         "x":240,
         "color":11184810
      });
      this.tf_check = ComponentUtil.getTextField("",this,{
         "x":290,
         "color":8965358
      });
      this.tf_check.mouseEnabled = true;
      this.tf_check.htmlText = HtmlUtil.createLink(LangConfig.getWord("29345",2));
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":32,
         "y":22,
         "width":300,
         "height":2
      },Global.Img_Cdm);
      this.tf_check.addEventListener(TextEvent.LINK,this.checkLinkHd);
   }
   
   private function checkLinkHd(event:TextEvent) : void
   {
      var url:String = Util.rep(HuaShanUtil.xuanBaSaiRep,this._jie,this._bangType2,this._lun,this._chang,this._index);
      Utils.print(url);
      HuaShanUtil.questServ(url);
   }
   
   public function set index(value:int) : void
   {
      this._index = value;
      this.tf_title.htmlText = Util.rep(LangConfig.getWord("29346",2),value.toString());
   }
   
   public function update(jie:int, bangType2:int, lun:int, chang:int, data:Object) : void
   {
      var role1Info:Array = data[0];
      var role2Info:Array = data[1];
      var result:int = int(data[2]);
      this._jie = jie;
      this._bangType2 = bangType2;
      this._lun = lun;
      this._chang = chang;
      var winnerName:String = result == 1 ? role1Info[Enum_HuaShan.CONT_ROLENAME] + ".S" + role1Info[Enum_HuaShan.CONT_SERVNAME] : role2Info[Enum_HuaShan.CONT_ROLENAME] + ".S" + role2Info[Enum_HuaShan.CONT_SERVNAME];
      this.tf_playerName.htmlText = "【<font color=\'#f08800\'>" + Model_heFu.repNameByHero(winnerName) + "</font>】";
   }
   
   public function dispose() : void
   {
      removeChild(this.tf_title);
      removeChild(this.tf_playerName);
      removeChild(this.tf_result);
      removeChild(this.tf_check);
      this.tf_title.dispose();
      this.tf_playerName.dispose();
      this.tf_result.dispose();
      this.tf_check.dispose();
      this.tf_title = null;
      this.tf_playerName = null;
      this.tf_result = null;
      this.tf_check = null;
   }
}
