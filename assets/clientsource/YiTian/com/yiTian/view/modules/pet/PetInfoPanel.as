package com.yiTian.view.modules.pet
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class PetInfoPanel extends Panel
   {
      
      private var petGrid:View_Grid;
      
      private var nameTxt:MyTextField;
      
      private var levelTxt:MyTextField;
      
      private var chengZhangTxt:MyTextField;
      
      private var ziZhiTxt:MyTextField;
      
      private var propertyTxt:MyTextField;
      
      private var jiNengTxt:MyTextField;
      
      private var noteTxt:MyTextField;
      
      private var zhanLiTxt:MyTextField;
      
      private var back:DisplayObject;
      
      private var staticTxt:Array;
      
      private var _petVO:PetVO;
      
      private var vo:Vo_grid;
      
      private var jinengVO:Vo_Skill;
      
      private var str:String;
      
      public function PetInfoPanel()
      {
         super();
         bindParent = GameScene.sysLayer;
      }
      
      public function set petVO(value:PetVO) : void
      {
         this._petVO = value;
      }
      
      public function get petVO() : PetVO
      {
         return this._petVO;
      }
      
      override protected function initStaticView() : void
      {
         var t:MyTextField = null;
         this.staticTxt = [{
            "txt":LangConfig.getWord("10084",1) + "：",
            "x":54,
            "y":11
         },{
            "txt":LangConfig.getWord("10085",1) + "：",
            "x":54,
            "y":28.5
         },{
            "txt":LangConfig.getWord("10086",1) + "：",
            "x":11,
            "y":49
         },{
            "txt":LangConfig.getWord("10087",1) + "：",
            "x":11,
            "y":67.5
         },{
            "txt":LangConfig.getWord("10088",1) + "：",
            "x":11,
            "y":86
         },{
            "txt":LangConfig.getWord("10089",1) + "：",
            "x":11,
            "y":106
         },{
            "txt":LangConfig.getWord("10090",1) + "：",
            "x":11,
            "y":240.5
         }];
         this.back = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "x":0,
            "y":0,
            "width":195
         },Global.Img_Cdm);
         var i:int = 0;
         while(i < this.staticTxt.length)
         {
            t = ComponentUtil.getTextField(this.staticTxt[i].txt,this,{
               "x":this.staticTxt[i].x,
               "y":this.staticTxt[i].y,
               "color":11515029
            });
            i++;
         }
         move = new Rectangle(0,0,195,20);
         this.petGrid = new View_Grid(false,".jpg");
         this.petGrid.type = Enum_type_grid.PET;
         this.petGrid.set_bmp_bg();
         this.petGrid.x = 14;
         this.petGrid.y = 11;
         addChild(this.petGrid);
         this.nameTxt = ComponentUtil.getTextField(LangConfig.getWord("10084",1),this,{
            "x":116.2,
            "y":11,
            "color":14013822
         });
         this.nameTxt.text = LangConfig.getWord("10084",1);
         this.levelTxt = ComponentUtil.getTextField(Data_lib.attribute[23][0],this,{
            "x":116.2,
            "y":28.5,
            "color":14013822
         });
         this.chengZhangTxt = ComponentUtil.getTextField(LangConfig.getWord("10086",1) + "：",this,{
            "x":74.2,
            "y":67.5,
            "color":14013822
         });
         this.ziZhiTxt = ComponentUtil.getTextField(LangConfig.getWord("10087",1) + "：",this,{
            "x":74.2,
            "y":49,
            "color":14013822
         });
         this.zhanLiTxt = ComponentUtil.getTextField(LangConfig.getWord("10088",1) + "：",this,{
            "x":74.2,
            "y":86,
            "color":14013822
         });
         this.propertyTxt = ComponentUtil.getTextField("",this,{
            "x":74.2,
            "y":106
         });
         this.propertyTxt.realWidth = 100;
         this.propertyTxt.wordWrap = true;
         this.propertyTxt.leading = 5;
         this.propertyTxt.htmlText = "";
         this.jiNengTxt = ComponentUtil.getTextField("",this,{
            "x":74.2,
            "y":240
         });
         this.jiNengTxt.realWidth = 100;
         this.jiNengTxt.wordWrap = true;
         this.jiNengTxt.leading = 1;
         this.jiNengTxt.htmlText = "";
         this.noteTxt = ComponentUtil.getTextField(LangConfig.getWord("10092",1),this,{
            "x":11,
            "y":0,
            "color":11304246
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":162,
            "y":5
         },Global.Img_Cdm);
      }
      
      public function update() : void
      {
         this.vo = new Vo_grid();
         this.vo.str_icon = this._petVO.img + "_34";
         this.petGrid.vo = this.vo;
         this.nameTxt.text = this._petVO.name;
         this.levelTxt.text = this._petVO.level.toString();
         this.chengZhangTxt.text = this._petVO.CZLevel.toString();
         this.ziZhiTxt.text = this._petVO.ziZhi.toString();
         this.zhanLiTxt.text = this._petVO.zhanLi.toString();
         this.propertyTxt.text = Data_lib.attribute[3][0] + " " + this._petVO.maxQiXue + "\n" + Data_lib.attribute[1][0] + " " + this._petVO.gongJi + "\n" + Data_lib.attribute[2][0] + " " + this._petVO.fangYu + "\n" + Data_lib.attribute[87][0] + " " + this._petVO.mingZhong + "\n" + Data_lib.attribute[8][0] + " " + this._petVO.shanBi + "\n" + Data_lib.attribute[9][0] + " " + this._petVO.baoJi + "\n" + LangConfig.getWord("10093",1) + " " + this._petVO.suDu;
         this.str = "<font color=\'#FD5E00\'>";
         var i:uint = 0;
         while(i < this._petVO.jiNengArr.length)
         {
            this.jinengVO = new Vo_Skill(this._petVO.jiNengArr[i]);
            this.str += this.jinengVO.str_name + "\n";
            i++;
         }
         this.jiNengTxt.htmlText = this.str + "</font>";
         this.noteTxt.y = this.jiNengTxt.y + this.jiNengTxt.textHeight + 5;
         CloseButton.x = this.nameTxt.x + this.nameTxt.textWidth + 15;
         this.back.width = this.nameTxt.x + this.nameTxt.textWidth + 45;
         this.back.height = this.noteTxt.y + 25;
         move = new Rectangle(0,0,this.back.width,this.back.height);
         this.setChildIndex(CloseButton,this.numChildren - 1);
      }
   }
}

