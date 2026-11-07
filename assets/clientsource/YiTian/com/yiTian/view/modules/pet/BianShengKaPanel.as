package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.vo.Vo_Buffer;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.roleHead.BuffterVO;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class BianShengKaPanel extends Panel
   {
      
      private const ITEM_LENGTH:int = 5;
      
      private var vecBtn:Vector.<Button>;
      
      private var vecItem:Vector.<Item>;
      
      private var idArr:Vector.<int> = new <int>[0,46302,46303,46304,46305];
      
      private var vecModelId:Vector.<int> = new <int>[0,20902,20903,20904,20905];
      
      private var vecVO:Vector.<Vo_item>;
      
      private var isFirstOpen:Boolean = true;
      
      public function BianShengKaPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:uint = 0;
         var btn:Button = null;
         var vo:Vo_item = null;
         var item:Item = null;
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":694 + 160,
            "height":373
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":646 + 160,
            "height":323
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,40);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":660 + 160,
            "y":6
         },Global.Img_Cdm);
         i = uint(this.ITEM_LENGTH);
         this.vecBtn = new Vector.<Button>(i,true);
         this.vecItem = new Vector.<Item>(i,true);
         this.vecVO = new Vector.<Vo_item>(i,true);
         while(Boolean(i--))
         {
            if(Boolean(i))
            {
               vo = new Vo_item();
               vo.id = this.idArr[i];
               vo.Init_lib();
               this.vecVO[i] = vo;
               item = new Item(vo.str_name);
               addChild(item);
               item.x = 34 + i * (192 - 34);
               item.y = 50;
               this.vecItem[i] = item;
               item.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
               item.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
               btn = ComponentUtil.getButton(LangConfig.getWord("10041",1),"Button_Four",this,{"textColor":16184781},Global.Img_Cdm);
               btn.x = item.x + 40;
               btn.y = item.y + 250;
               btn.addEventListener(MouseEvent.CLICK,this.btnOnClick);
               btn.name = "btn_" + i;
               this.vecBtn[i] = btn;
            }
            else
            {
               item = new Item("");
               addChild(item);
               item.x = 34 + i * (192 - 34);
               item.y = 50;
               this.vecItem[i] = item;
               btn = ComponentUtil.getButton("","Button_Four",this,{"textColor":16184781},Global.Img_Cdm);
               btn.x = item.x + 40;
               btn.y = item.y + 250;
               btn.addEventListener(MouseEvent.CLICK,this.btnOnClick);
               btn.name = "btn_" + i;
               this.vecBtn[i] = btn;
            }
         }
         ComponentUtil.getTextField(LangConfig.getWord("10145",1),this,{
            "x":40,
            "y":337,
            "color":16764206,
            "size":12,
            "leading":0
         });
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         var index:int = this.vecItem.indexOf(e.target);
         TipManager.update(this.vecVO[index]);
         TipManager.view_tip.x = Global.stage.mouseX;
         TipManager.view_tip.y = Global.stage.mouseY;
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      protected function btnOnClick(e:MouseEvent) : void
      {
         var m:int;
         var vo:Vo_item = null;
         var index:int = int(e.target.name.split("_")[1]);
         if(index == 0)
         {
            if(e.target.label == "变身")
            {
               PetCGMessage.CG_PET_YUANXING();
            }
            else
            {
               UIManager.yellowDiamond.visible = true;
            }
            return;
         }
         m = GameUnitManager.hero.money;
         if(m < 168)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10044",1));
         }
         else
         {
            vo = new Vo_item();
            vo.id = this.idArr[index];
            vo.Init_lib();
            View_Alert.show("<font color=\'#FFFFFF\'>" + LangConfig.getWord("10045",1) + "<font color=\'#FFFF00\'>168" + LangConfig.getWord("10043",1) + "</font>" + LangConfig.getWord("10046",1) + "<font color=\'#FFFF00\'>" + this.getName(vo) + "</font>" + LangConfig.getWord("10047",1) + "</font>",View_Alert.OK_CANCAL,function():void
            {
               var sid:int = 0;
               sid = int(setTimeout(function():void
               {
                  var pb:* = BuffterVO.petBuffVOVec;
                  var isHave:* = pb.some(function(element:Vo_Buffer, index:int, arr:Vector.<Vo_Buffer>):Boolean
                  {
                     return element.propsId != vo.id;
                  });
                  if(Boolean(pb.length) && Boolean(isHave))
                  {
                     View_Alert.show("是否使用宠物变身卡覆盖原来的效果？",View_Alert.OK_CANCAL,useResult,null,{"id":vo.id});
                  }
                  else
                  {
                     PetCGMessage.CG_PET_BIANSHENGKA(vo.id);
                     this.visible = false;
                  }
                  clearTimeout(sid);
               },1));
            });
         }
      }
      
      private function useResult(data:Object) : void
      {
         PetCGMessage.CG_PET_BIANSHENGKA(data.id);
         this.visible = false;
      }
      
      private function getName(vo:Vo_grid) : String
      {
         return vo.str_name.split(LangConfig.getWord("10049",1))[0];
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         var pvo:PetVO = null;
         var petvo:PetVO = null;
         super.visible = value;
         if(this.isFirstOpen && value)
         {
            this.isFirstOpen = false;
            Utils.loadTitle("lang/ch/Pet_Imgs.swf","Title_BodyChange",new Bitmap(),{
               "x":349,
               "y":5
            },this);
         }
         if(value)
         {
            i = 0;
            while(i < this.ITEM_LENGTH)
            {
               if(Boolean(i))
               {
                  pvo = UIManager.petPanel.petVO;
                  if(Boolean(pvo.hxjx))
                  {
                     this.vecItem[i].play(PetPanel.transtPetModelID(this.vecModelId[i]));
                  }
                  else
                  {
                     this.vecItem[i].play(this.vecModelId[i]);
                  }
               }
               else
               {
                  petvo = UIManager.petPanel.petVO;
                  if(Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
                  {
                     if(PetPanel._petVO.isHzLz > 0)
                     {
                        if(Boolean(petvo.hxjx))
                        {
                           if(petvo.img == PetPanel.transtPetModelID(20901))
                           {
                              this.vecItem[i].setTxtNameText("QQ企鹅");
                              this.vecItem[i].play(PetPanel.transtPetModelID(20908));
                           }
                           else
                           {
                              this.vecItem[i].setTxtNameText("熊猫");
                              this.vecItem[i].play(PetPanel.transtPetModelID(20901));
                           }
                        }
                        else if(petvo.img == 20901)
                        {
                           this.vecItem[i].setTxtNameText("QQ企鹅");
                           this.vecItem[i].play(20908);
                        }
                        else
                        {
                           this.vecItem[i].setTxtNameText("熊猫");
                           this.vecItem[i].play(20901);
                        }
                        this.vecItem[i].setTxtPrice("<font color=\'#b5a687\'>售价：</font><font color=\'#ffcd2e\'>免费</font>");
                        this.vecBtn[i].label = "变身";
                     }
                     else
                     {
                        this.vecItem[i].setTxtNameText("会员专属宠物");
                        if(Boolean(petvo.hxjx))
                        {
                           if(petvo.img == PetPanel.transtPetModelID(20901))
                           {
                              this.vecItem[i].setTxtNameText("QQ企鹅");
                              this.vecItem[i].play(PetPanel.transtPetModelID(20908));
                           }
                           else
                           {
                              this.vecItem[i].setTxtNameText("熊猫");
                              this.vecItem[i].play(PetPanel.transtPetModelID(20901));
                           }
                        }
                        else if(petvo.img == 20901)
                        {
                           this.vecItem[i].setTxtNameText("QQ企鹅");
                           this.vecItem[i].play(20908);
                        }
                        else
                        {
                           this.vecItem[i].setTxtNameText("熊猫");
                           this.vecItem[i].play(20901);
                        }
                        this.vecItem[i].setTxtPrice("<font color=\'#ffcd2e\'>开通QQ会员可永久获得</font>");
                        this.vecBtn[i].label = "会员特权";
                     }
                  }
                  else if(Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.PENGYOU || Enum_SPStr.isIwan(Global.pf))
                  {
                     if(PetPanel._petVO.isHzLz > 0)
                     {
                        if(Boolean(petvo.hxjx))
                        {
                           if(petvo.img == PetPanel.transtPetModelID(20901))
                           {
                              this.vecItem[i].setTxtNameText("麒麟");
                              this.vecItem[i].play(PetPanel.transtPetModelID(20906));
                           }
                           else
                           {
                              this.vecItem[i].setTxtNameText("熊猫");
                              this.vecItem[i].play(PetPanel.transtPetModelID(20901));
                           }
                        }
                        else if(petvo.img == 20901)
                        {
                           this.vecItem[i].setTxtNameText("麒麟");
                           this.vecItem[i].play(20906);
                        }
                        else
                        {
                           this.vecItem[i].setTxtNameText("熊猫");
                           this.vecItem[i].play(20901);
                        }
                        this.vecItem[i].setTxtPrice("<font color=\'#b5a687\'>售价：</font><font color=\'#ffcd2e\'>免费</font>");
                        this.vecBtn[i].label = "变身";
                     }
                     else
                     {
                        this.vecItem[i].setTxtNameText("黄钻专属宠物");
                        if(Boolean(petvo.hxjx))
                        {
                           if(petvo.img == PetPanel.transtPetModelID(20901))
                           {
                              this.vecItem[i].setTxtNameText("麒麟");
                              this.vecItem[i].play(PetPanel.transtPetModelID(20906));
                           }
                           else
                           {
                              this.vecItem[i].setTxtNameText("熊猫");
                              this.vecItem[i].play(PetPanel.transtPetModelID(20901));
                           }
                        }
                        else if(petvo.img == 20901)
                        {
                           this.vecItem[i].setTxtNameText("麒麟");
                           this.vecItem[i].play(20906);
                        }
                        else
                        {
                           this.vecItem[i].setTxtNameText("熊猫");
                           this.vecItem[i].play(20901);
                        }
                        this.vecItem[i].setTxtPrice("<font color=\'#ffcd2e\'>开通QQ黄钻可永久获得</font>");
                        this.vecBtn[i].label = "黄钻特权";
                     }
                  }
                  else if(Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQ3366 || Global.pf == Enum_SPStr.CHITU)
                  {
                     if(PetPanel._petVO.isHzLz > 0)
                     {
                        if(Boolean(petvo.hxjx))
                        {
                           if(petvo.img == PetPanel.transtPetModelID(20901))
                           {
                              this.vecItem[i].setTxtNameText("布鲁");
                              this.vecItem[i].play(PetPanel.transtPetModelID(20907));
                           }
                           else
                           {
                              this.vecItem[i].setTxtNameText("熊猫");
                              this.vecItem[i].play(PetPanel.transtPetModelID(20901));
                           }
                        }
                        else if(petvo.img == 20901)
                        {
                           this.vecItem[i].setTxtNameText("布鲁");
                           this.vecItem[i].play(20907);
                        }
                        else
                        {
                           this.vecItem[i].setTxtNameText("熊猫");
                           this.vecItem[i].play(20901);
                        }
                        this.vecItem[i].setTxtPrice("<font color=\'#b5a687\'>售价：</font><font color=\'#ffcd2e\'>免费</font>");
                        this.vecBtn[i].label = "变身";
                     }
                     else
                     {
                        this.vecItem[i].setTxtNameText("蓝钻专属宠物");
                        if(Boolean(petvo.hxjx))
                        {
                           if(petvo.img == PetPanel.transtPetModelID(20901))
                           {
                              this.vecItem[i].setTxtNameText("布鲁");
                              this.vecItem[i].play(PetPanel.transtPetModelID(20907));
                           }
                           else
                           {
                              this.vecItem[i].setTxtNameText("熊猫");
                              this.vecItem[i].play(PetPanel.transtPetModelID(20901));
                           }
                        }
                        else if(petvo.img == 20901)
                        {
                           this.vecItem[i].setTxtNameText("布鲁");
                           this.vecItem[i].play(20907);
                        }
                        else
                        {
                           this.vecItem[i].setTxtNameText("熊猫");
                           this.vecItem[i].play(20901);
                        }
                        if(Global.pf == Enum_SPStr.CHITU)
                        {
                           this.vecItem[i].setTxtNameText("熊猫");
                           this.vecItem[i].setTxtPrice("<font color=\'#b5a687\'>售价：</font><font color=\'#ffcd2e\'>免费</font>");
                           this.vecBtn[i].label = "变身";
                        }
                        else
                        {
                           this.vecItem[i].setTxtNameText("布鲁");
                           this.vecItem[i].setTxtPrice("<font color=\'#ffcd2e\'>开通QQ蓝钻可永久获得</font>");
                           this.vecBtn[i].label = "蓝钻特权";
                        }
                     }
                  }
               }
               i++;
            }
         }
         else
         {
            i = 0;
            while(i < this.ITEM_LENGTH)
            {
               this.vecItem[i].stop();
               i++;
            }
         }
      }
      
      public function resetP() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.utils.Utils;
import com.yiTian.view.modules.pet.PanelModel;
import flash.display.Bitmap;
import flash.text.TextFormatAlign;

class Item extends PanelModel
{
   
   private var txtName:MyTextField;
   
   private var txtPrice:MyTextField;
   
   private var bmBack:Bitmap = new Bitmap();
   
   public function Item(_name:String)
   {
      addChild(this.bmBack);
      super(80,180);
      Utils.loadTitle("lang/ch/Pet_Imgs.swf","Back_Card",this.bmBack);
      this.txtName = ComponentUtil.getTextField("",this,{
         "x":40,
         "y":9,
         "color":3644132,
         "size":12,
         "leading":0
      });
      this.txtName.realWidth = 78;
      this.txtName.align = TextFormatAlign.CENTER;
      this.txtName.text = _name;
      this.txtPrice = ComponentUtil.getTextField("",this,{"y":215});
      this.txtPrice.align = TextFormatAlign.CENTER;
      this.txtPrice.realWidth = 153;
      this.txtPrice.htmlText = "<font color=\'#b5a687\'>售价：</font><font color=\'#ffcd2e\'>168元宝</font>";
   }
   
   public function setTxtNameText(value:String) : void
   {
      this.txtName.text = value;
   }
   
   public function setTxtPrice(value:String) : void
   {
      this.txtPrice.htmlText = value;
   }
}
