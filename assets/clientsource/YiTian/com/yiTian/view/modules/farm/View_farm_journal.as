package com.yiTian.view.modules.farm
{
   import Layout.ILayout;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_farm_fruit;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.net.message.cg.RoleCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   
   public class View_farm_journal extends Panel
   {
      
      private var pageRight_Button:Button;
      
      private var pageLeft_Button:Button;
      
      private var page_text:MyTextField;
      
      private var l:ILayout;
      
      private var _curPage:int = 1;
      
      private var _totalPage:int;
      
      private var isLoad:Boolean = false;
      
      public function View_farm_journal()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":499,
            "height":387
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":23,
            "y":40,
            "width":451,
            "height":337
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":30,
            "y":48,
            "width":437,
            "height":294
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":32,
            "y":50,
            "width":433,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":222,
            "y":350,
            "width":56,
            "height":17
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("106",9),this,{
            "x":167,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("107",9),this,{
            "x":376,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,441,36);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":465,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         var i:int = 0;
         while(i < 10)
         {
            ComponentUtil.getScaleBitmap("Title_Back2",[29,2,2,16],this,{
               "x":34,
               "y":69 + 27 * i,
               "width":433,
               "height":30
            },Global.Img_Cdm);
            i++;
         }
         this.pageRight_Button = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":278,
            "y":348,
            "textColor":16184781
         },Global.Img_Cdm);
         this.pageLeft_Button = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":202,
            "y":348,
            "textColor":16184781
         },Global.Img_Cdm);
         this.page_text = ComponentUtil.getTextField("1/1",this,{
            "x":232,
            "y":349,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.pageLeft_Button.name = "minus";
         this.pageRight_Button.name = "add";
         this.pageLeft_Button.addEventListener(MouseEvent.CLICK,this.pageChangeHandle);
         this.pageRight_Button.addEventListener(MouseEvent.CLICK,this.pageChangeHandle);
      }
      
      public function pageChangeHandle(e:MouseEvent) : void
      {
         var temBtn:Button = e.target as Button;
         if(temBtn.name == "add")
         {
            if(this._curPage == this._totalPage)
            {
               return;
            }
            ++this._curPage;
            if(this._curPage > this._totalPage)
            {
               this._curPage = this._totalPage;
            }
         }
         else
         {
            if(this._curPage == 1)
            {
               return;
            }
            --this._curPage;
            if(this._curPage < 1)
            {
               this._curPage = 1;
            }
         }
         this.update(this._curPage);
      }
      
      public function update(_cup:int) : void
      {
         var j:int = 0;
         var temN:int = 0;
         this._curPage = _cup;
         if(!Model_farm.instace.farm_journal.length)
         {
            this.page_text.text = "1/1";
            return;
         }
         if(Model_farm.instace.farm_journal.length % 10 == 0)
         {
            this._totalPage = Model_farm.instace.farm_journal.length / 10;
         }
         else
         {
            this._totalPage = Model_farm.instace.farm_journal.length / 10 + 1;
         }
         var i:int = 0;
         while(i < Model_farm.instace.farm_journal.length)
         {
            Model_farm.instace.farm_journal[i][0].visible = false;
            Model_farm.instace.farm_journal[i][1].visible = false;
            i++;
         }
         this.page_text.text = String(this._curPage) + "/" + String(this._totalPage);
         if(this._curPage != this._totalPage)
         {
            j = 0;
            while(j < 10)
            {
               Model_farm.instace.farm_journal[j + (this._curPage - 1) * 10][0].visible = true;
               Model_farm.instace.farm_journal[j + (this._curPage - 1) * 10][0].y = 68 + 27 * j;
               Model_farm.instace.farm_journal[j + (this._curPage - 1) * 10][1].visible = true;
               Model_farm.instace.farm_journal[j + (this._curPage - 1) * 10][1].y = 75 + j * 27;
               j++;
            }
         }
         else
         {
            temN = Model_farm.instace.farm_journal.length % 10 + 10 * int(Model_farm.instace.farm_journal.length % 10 == 0);
            j = 0;
            while(j < temN)
            {
               Model_farm.instace.farm_journal[j + (this._curPage - 1) * 10][0].visible = true;
               Model_farm.instace.farm_journal[j + (this._curPage - 1) * 10][0].y = 68 + j * 27;
               Model_farm.instace.farm_journal[j + (this._curPage - 1) * 10][1].visible = true;
               Model_farm.instace.farm_journal[j + (this._curPage - 1) * 10][1].y = 75 + j * 27;
               j++;
            }
         }
      }
      
      public function updateJournal(type:int, name:String, id:Number, sex:int, num:int, fruitId:Number, farmerName:String, farmerSex:uint, timer:int) : void
      {
         var nameText:MyTextField = null;
         var fruitName:String = null;
         var farmerTxt:MyTextField = null;
         var sprite:Sprite = new Sprite();
         addChild(sprite);
         var sp:Sprite = new Sprite();
         sp.name = id.toString();
         sprite.addChild(sp);
         name = Model_heFu.repNameByHero(name);
         var journal:MyTextField = ComponentUtil.getTextField("",sprite,{
            "x":55,
            "y":6,
            "color":11904647,
            "size":12,
            "leading":0
         });
         var timeText:MyTextField = ComponentUtil.getTextField("",this,{
            "x":358,
            "y":6,
            "color":11904647,
            "size":12,
            "leading":0
         });
         nameText = ComponentUtil.getTextField("",sp,{
            "x":55,
            "y":6,
            "color":11904647,
            "size":12,
            "leading":0
         });
         nameText.htmlText = "<u><font color=\'#ffff00\'>" + name + "</font></u>";
         if(type == 1)
         {
            fruitName = "<font color= \'" + Model_farm.fruitColor1[Data_lib.farm_fruit[fruitId][Vo_farm_fruit.fruitCharacter] - 1] + "\'>" + Data_lib.farm_fruit[fruitId][Vo_farm_fruit.name] + "</font>";
            journal.htmlText = nameText.htmlText + LangConfig.getWord("108",9,num) + fruitName;
         }
         else if(type == 3)
         {
            farmerTxt = ComponentUtil.getTextField("",sprite,{
               "x":nameText.x + nameText.width + 32,
               "y":6,
               "color":16776960,
               "size":12,
               "leading":0
            });
            name = HtmlUtil.createLink(farmerName,true,"roleInfo");
            farmerTxt.htmlText = name;
            farmerTxt.name = fruitId.toString();
            farmerTxt.alpha = 0;
            farmerTxt.mouseEnabled = true;
            farmerTxt.addEventListener(TextEvent.LINK,this.linkHandle);
            journal.htmlText = nameText.htmlText + LangConfig.getWord("195",9,farmerTxt.htmlText);
         }
         else if(type == 0)
         {
         }
         timeText.text = DateUtil.getYMDHM(timer);
         Model_farm.instace.farm_journal.push([sprite,timeText]);
         sp.addEventListener(MouseEvent.CLICK,this.clickHandle);
         sp.buttonMode = true;
      }
      
      private function linkHandle(event:TextEvent) : void
      {
         RoleCGMessage.CG_CHECK_OTHERROLE(Number(event.target.name));
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         RoleCGMessage.CG_CHECK_OTHERROLE(Number(evt.target.name));
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         super.visible = value;
         if(value)
         {
            if(!this.isLoad)
            {
               this.showTl();
               this.isLoad = true;
            }
            i = 0;
            while(i < Model_farm.instace.farm_journal.length)
            {
               Model_farm.instace.farm_journal[i][0].visible = false;
               Model_farm.instace.farm_journal[i][1].visible = false;
               i++;
            }
            Model_farm.instace.farm_journal = [];
            FarmCGMessage.cg_farm_journal(Model_farm.instace.masterBasic_mine.id);
         }
      }
      
      private function showTl() : void
      {
         ComponentUtil.getBitmap("BT_SZRiZhi",this,{
            "x":170,
            "y":5
         },Global.ShanZhuang_Imgsdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

