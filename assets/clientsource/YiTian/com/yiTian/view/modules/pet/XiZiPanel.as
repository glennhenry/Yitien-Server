package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_Pet;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.pet.petD.EffectPan;
   import com.yiTian.view.modules.pet.petD.Model_pet;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class XiZiPanel extends EffectPan
   {
      
      public static var idArr:Array = [46310,46311,46312];
      
      private const WIDTH:int = 218;
      
      private const HEIGHT:int = 10;
      
      private var ziZhiBM:Bitmap;
      
      private var ziZhiMask:Shape;
      
      private var ziZhiTxt:MyTextField;
      
      public var xiZiBtn:Button;
      
      private var nowItem:PetListItem;
      
      private var itemVec:Vector.<PetListItem>;
      
      private var pingZiTxt:MyTextField;
      
      private var stepFContainer:Sprite;
      
      private var stepSContainer:Sprite;
      
      private var beyondBtn:Button;
      
      private var tfBind:MyTextField;
      
      private var curItem:PetListItem;
      
      private var data:Array = [];
      
      private var defaultItem:Vo_Pet;
      
      private var storeIdArr:Array = [];
      
      private var ziZhiBG:Bitmap;
      
      private var tuPoLvl:int;
      
      private var maxLength:int;
      
      private var _Tarr:Array = [100,150,200,250,300,350];
      
      private var eff:Effect;
      
      private var effSp:Sprite;
      
      public function XiZiPanel()
      {
         var i:int = 0;
         var item:PetListItem = null;
         super();
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":-2,
            "y":0,
            "width":245,
            "height":283
         },Global.Img_Cdm);
         this.stepFContainer = new Sprite();
         addChild(this.stepFContainer);
         this.stepSContainer = new Sprite();
         addChild(this.stepSContainer);
         this.stepSContainer.visible = true;
         this.stepFContainer.visible = false;
         Model_pet.addUnit(this.stepSContainer);
         this.tfBind = ComponentUtil.getTextField("说明",this,{
            "x":195,
            "y":10,
            "color":16742144,
            "size":12,
            "leading":0,
            "underline":true,
            "mouseEnabled":true
         });
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.stepFContainer,{
            "x":8,
            "y":52,
            "width":220,
            "height":160
         },Global.Img_Cdm);
         this.pingZiTxt = ComponentUtil.getTextField("",this,{
            "x":10,
            "y":10,
            "color":11904647
         });
         this.ziZhiBG = new Bitmap();
         this.ziZhiBG.x = 8;
         this.ziZhiBG.y = 31;
         addChild(this.ziZhiBG);
         this.ziZhiBM = new Bitmap();
         this.ziZhiBM.x = 9;
         this.ziZhiBM.y = 32;
         addChild(this.ziZhiBM);
         this.ziZhiMask = new Shape();
         this.draw(this.ziZhiMask,this.WIDTH);
         addChild(this.ziZhiMask);
         this.ziZhiMask.x = this.ziZhiBM.x;
         this.ziZhiMask.y = this.ziZhiBM.y;
         this.ziZhiBM.mask = this.ziZhiMask;
         this.ziZhiTxt = ComponentUtil.getTextField("100/100",this,{
            "x":this.ziZhiBM.x,
            "y":this.ziZhiBM.y - 5
         });
         this.ziZhiTxt.realWidth = this.WIDTH;
         this.ziZhiTxt.align = TextFormatAlign.CENTER;
         this.xiZiBtn = ComponentUtil.getButton(LangConfig.getWord("10136",1),"Button_Orange",this.stepFContainer,{
            "x":82,
            "y":235,
            "textColor":16184781
         },Global.Img_Cdm);
         this.xiZiBtn.textColor = 16383744;
         this.xiZiBtn.textOverColor = 16383744;
         this.xiZiBtn.addEventListener(MouseEvent.CLICK,this.xiZiHandler);
         this.itemVec = new Vector.<PetListItem>();
         i = 0;
         while(i < 3)
         {
            item = new PetListItem(PetPanel.XIZI);
            this.stepFContainer.addChild(item);
            item.x = 17.3;
            item.y = 62 + (40 + 5) * i;
            item.addEventListener(MouseEvent.CLICK,this.onClick);
            this.itemVec.push(item);
            i++;
         }
         this.itemVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      private function draw(shape:Shape, width:int) : void
      {
         shape.graphics.beginFill(0,1);
         shape.graphics.drawRect(0,0,this.WIDTH,this.HEIGHT);
         shape.graphics.endFill();
      }
      
      protected function onClick(event:MouseEvent) : void
      {
         var item:PetListItem = event.currentTarget as PetListItem;
         if(this.curItem == item)
         {
            return;
         }
         if(Boolean(this.curItem))
         {
            this.curItem.choose = false;
         }
         item.choose = true;
         this.curItem = item;
      }
      
      protected function gridOnUp(event:MouseEvent) : void
      {
         var dragGrid:View_Grid = null;
         var petVO:Vo_Pet = null;
         if(UIManager.isDrag)
         {
            dragGrid = UIManager.dragObj.grid;
            petVO = dragGrid.vo as Vo_Pet;
            if(Boolean(petVO) && petVO.petPanelType == PetPanel.XIZI)
            {
            }
         }
      }
      
      public function changeGrid(vo:Vo_Pet) : void
      {
         if(vo.petPanelType == PetPanel.XIZI)
         {
         }
      }
      
      protected function xiZiHandler(event:MouseEvent) : void
      {
         var vec:Vector.<Vo_valuable>;
         var isNo:Boolean;
         var temp:Array = null;
         var i:uint = 0;
         var descrip:String = null;
         if(UIManager.petPanel.petVO.ziZhi == 350)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10137",1));
            return;
         }
         vec = CommandManager.get_bag_vec(Enum_filter.ITEM_PET_APTITUDE);
         isNo = false;
         if(vec.length > 0)
         {
            temp = [];
            i = 0;
            while(i < vec.length)
            {
               if(vec[i].id == this.curItem.data.id)
               {
                  temp.push(vec[i]);
                  isNo = true;
               }
               i++;
            }
            temp.sortOn("bBind",Array.NUMERIC | Array.DESCENDING);
            if(isNo)
            {
               descrip = "";
               if(UIManager.petPanel.petVO.ziZhi > 250)
               {
                  descrip = "洗髓";
               }
               else
               {
                  descrip = "洗资质";
               }
               View_Alert.show(LangConfig.getWord("10138",1,UIManager.petPanel.petVO.ziZhi).replace("冼资质",descrip),View_Alert.OK_CANCAL,function():void
               {
                  PetCGMessage.CG_PET_XIZI(temp[0].gridId);
               });
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10139",1));
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10139",1));
         }
      }
      
      protected function hideKSGM(event:MouseEvent) : void
      {
      }
      
      public function update(res:int = 0) : void
      {
         var temp:int = 0;
         var str:String = null;
         var petVO:PetVO = UIManager.petPanel.petVO;
         var data:Object = Model_pet.handleOfPetXiZhi(petVO.ziZhi);
         this.maxLength = data.maxWidth;
         this.tuPoLvl = data.jinJiLevl;
         if(this.tuPoLvl == 0 || this.tuPoLvl == 6)
         {
            this.stepSContainer.visible = false;
            this.stepFContainer.visible = true;
         }
         else
         {
            this.stepSContainer.visible = true;
            this.stepFContainer.visible = false;
         }
         Model_pet.updateLvl(this.tuPoLvl);
         Model_pet.updateRate(res);
         var w:int = petVO.ziZhi > this.maxLength ? this.WIDTH : int(petVO.ziZhi / this.maxLength * this.WIDTH);
         var _lv:int = this._Tarr.indexOf(this.maxLength);
         if(petVO.ziZhi > 250)
         {
            temp = this._Tarr.indexOf(petVO.ziZhi);
            str = "<font color=\'#00ffff\'>" + "宠物资质突破" + "</font>" + "<font color=\'#ff7700\'>" + "\n宠物通过宠物洗髓即可提升宠物资质，洗资质丹的品质越好，洗髓的成功率越大！" + "</font>";
            if(temp == -1)
            {
               TipManager.bind(this.tfBind,str);
            }
            else
            {
               TipManager.bind(this.tfBind,Model_pet.desCripArr[_lv]);
            }
         }
         else
         {
            TipManager.bind(this.tfBind,Model_pet.desCripArr[_lv]);
         }
         if(petVO.ziZhi >= 350)
         {
            this.tfBind.visible = false;
         }
         if(_lv >= 4)
         {
            this.xiZiBtn.label = "洗髓";
         }
         this.ziZhiMask.width = w;
         this.ziZhiTxt.text = petVO.ziZhi + "/" + this.maxLength;
         this.pingZiTxt.htmlText = LangConfig.getWord("10140",1) + this.nameColor;
         this.updateItem();
      }
      
      private function get nameColor() : String
      {
         var value:int = UIManager.petPanel.petVO.ziZhi;
         if(value >= 1 && value <= 50)
         {
            return "<font color=\'" + ColorConstant.getColorStr(ColorConstant.WHITE) + "\'>" + LangConfig.getWord("10141",1) + "</font>";
         }
         if(value >= 51 && value <= 70)
         {
            return "<font color=\'" + ColorConstant.getColorStr(ColorConstant.GREEN) + "\'>" + LangConfig.getWord("10142",1) + "</font>";
         }
         if(value >= 71 && value <= 90)
         {
            return "<font color=\'" + ColorConstant.getColorStr(ColorConstant.BLUE) + "\'>" + LangConfig.getWord("10143",1) + "</font>";
         }
         if(value >= 91 && value <= 100)
         {
            return "<font color=\'" + ColorConstant.getColorStr(ColorConstant.PURPLE) + "\'>" + LangConfig.getWord("10144",1) + "</font>";
         }
         if(value >= 101 && value <= 150)
         {
            return "<font color=\'" + ColorConstant.getColorStr(ColorConstant.PURPLE) + "\' size=\'14\'>" + "灵品" + "</font>";
         }
         if(value >= 151 && value <= 200)
         {
            return "<font color=\'" + ColorConstant.getColorStr(ColorConstant.ORANGE) + "\' size=\'14\'>" + "仙品" + "</font>";
         }
         if(value > 200 && value <= 250)
         {
            return "<font color=\'" + ColorConstant.getColorStr(ColorConstant.ORANGE) + "\' size=\'14\'>" + "圣品" + "</font>";
         }
         if(value > 250 && value <= 300)
         {
            return "<font color=\'" + ColorConstant.getColorStr(ColorConstant.ANJIN) + "\' size=\'14\'>" + "神品" + "</font>";
         }
         if(value > 300 && value <= 350)
         {
            return "<font color=\'" + ColorConstant.getColorStr(ColorConstant.GOLD) + "\' size=\'14\'>" + "玄品" + "</font>";
         }
         return "";
      }
      
      private function updateItem() : void
      {
         var vec:Vector.<Vo_valuable> = null;
         var t:int = 0;
         var o:Object = null;
         var j:uint = 0;
         this.data = [];
         var _lv:int = this._Tarr.indexOf(this.maxLength);
         if(_lv > 0 && _lv < 6)
         {
            idArr = Model_pet.metiarialArr[_lv - 1];
         }
         var i:uint = 0;
         while(i < 3)
         {
            vec = CommandManager.get_bag_vec(Enum_filter.ID,null,[idArr[i]]);
            t = 0;
            if(Boolean(vec))
            {
               j = 0;
               while(j < vec.length)
               {
                  t += vec[j].count;
                  j++;
               }
            }
            o = {
               "id":idArr[i],
               "total":t
            };
            this.itemVec[i].update(o);
            this.data.push(o);
            i++;
         }
      }
      
      public function selectItem(id:int) : void
      {
         if(Boolean(id))
         {
            this.itemVec[idArr.indexOf(id)].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public function playEff() : void
      {
         if(!this.effSp)
         {
            this.effSp = new Sprite();
            addChild(this.effSp);
            this.effSp.scaleX = 0.6;
            this.effSp.scaleY = 0.6;
         }
         this.eff = EffectManager.addEffect("56918",this.effSp,600,200,70);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            Model_pet.addBagsUpdateFrame();
            this.updateItem();
            if(!this.ziZhiBG.bitmapData)
            {
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Pet_ProgressLoading_board",this.ziZhiBG);
            }
            if(!this.ziZhiBM.bitmapData)
            {
               Utils.loadTitle("lang/ch/Pet_Imgs.swf","Pet_ProgressLoading",this.ziZhiBM);
            }
            if(Boolean(this.data[2].total))
            {
               this.itemVec[2].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               return;
            }
            if(Boolean(this.data[1].total))
            {
               this.itemVec[1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               return;
            }
            if(Boolean(this.data[0].total))
            {
               this.itemVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               return;
            }
            this.itemVec[2].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else
         {
            Model_pet.removeBagsUpdateFrame();
         }
      }
   }
}

