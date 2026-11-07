package com.yiTian.net.message.gc
{
   import com.utils.LongUtil;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.LetterHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.view.modules.letter.LetterManagerVO;
   import com.yiTian.view.modules.letter.LetterVO;
   import flash.utils.IDataInput;
   
   public class LetterGCMessage
   {
      
      public function LetterGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_MAIL] = this.GC_MAIL;
         index[MessageType.GC_SEND_MAIL] = this.GC_SEND_MAIL;
         index[MessageType.GC_DELETE_MAIL] = GC_DELETE_MAIL;
         index[MessageType.GC_GET_ATTACHMENT] = this.GC_GET_ATTACHMENT;
         index[MessageType.GC_CLEAR_MAIL] = GC_CLEAR_MAIL;
         index[MessageType.GC_NEW_MAIL_NOTI] = GC_NEW_MAIL_NOTI;
      }
      
      public static function GC_DELETE_MAIL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var size:int = patch.readShort();
         LetterHandler.GC_DELETE_MAIL(result,size);
      }
      
      public static function GC_CLEAR_MAIL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var size:int = patch.readShort();
         LetterHandler.GC_CLEAR_MAIL(result,size);
      }
      
      public static function GC_NEW_MAIL_NOTI(patch:IDataInput) : void
      {
         LetterHandler.GC_NEW_MAIL_NOTI();
      }
      
      public function GC_MAIL(patch:IDataInput) : void
      {
         var i:uint = 0;
         var tempLetterVO:LetterVO = null;
         var ii_index:int = 0;
         var len:int = 0;
         var j:int = 0;
         var temp_basic:Array = null;
         var temp_intensify:Array = null;
         var temp_extra:Array = null;
         var temp_stoneId:Array = null;
         var extra_polish:String = null;
         var isGrey:int = 0;
         var skillId:int = 0;
         var skillGrade:int = 0;
         var jingLianCount:int = 0;
         var czLen:int = 0;
         var temp_jingLian_arr:Array = null;
         UIManager.letterManagerViewPanel.letterManageVO = new LetterManagerVO();
         var tempLMVP:LetterManagerVO = UIManager.letterManagerViewPanel.letterManageVO;
         var letterVOArr:Array = [];
         var result:int = patch.readByte();
         if(result == 1)
         {
            tempLMVP.type = patch.readByte();
            tempLMVP.currentPage = patch.readShort();
            tempLMVP.startPage = patch.readShort();
            tempLMVP.endPage = patch.readShort();
            tempLMVP.mailNum = patch.readInt();
            tempLMVP.totalPage = patch.readShort();
            tempLMVP.size = patch.readByte();
            i = 0;
            while(i < tempLMVP.size)
            {
               tempLetterVO = new LetterVO();
               tempLetterVO.id = LongUtil.readLong(patch);
               tempLetterVO.readFlag = patch.readByte();
               tempLetterVO.sender = patch.readUTF();
               tempLetterVO.sender = Model_heFu.repNameByHero(tempLetterVO.sender);
               tempLetterVO.addressee = patch.readUTF();
               tempLetterVO.addressee = Model_heFu.repNameByHero(tempLetterVO.addressee);
               tempLetterVO.sendTime = patch.readInt();
               tempLetterVO.content = patch.readUTF();
               tempLetterVO.content = Model_heFu.repNameByHero(tempLetterVO.content);
               tempLetterVO.msType = patch.readByte();
               tempLetterVO.msNum = patch.readInt();
               tempLetterVO.goodNum = patch.readShort();
               if(tempLetterVO.goodNum > 0)
               {
                  tempLetterVO.goodFlag = patch.readByte();
                  trace(",,,",tempLetterVO.goodFlag);
                  if(tempLetterVO.goodFlag == 1)
                  {
                     tempLetterVO.toolId = LongUtil.readLong(patch);
                  }
                  else
                  {
                     tempLetterVO.equipArr = [];
                     if(tempLMVP.type == 4)
                     {
                        tempLetterVO.equipId = patch.readInt();
                     }
                     else
                     {
                        tempLetterVO.equipArr.push(LongUtil.readLong(patch));
                        tempLetterVO.equipArr.push(patch.readInt());
                        tempLetterVO.equipArr.push(patch.readShort());
                        tempLetterVO.equipArr.push(patch.readByte());
                        tempLetterVO.equipArr.push(patch.readByte());
                        tempLetterVO.equipArr.push(patch.readByte());
                        tempLetterVO.equipArr.push(patch.readByte());
                        tempLetterVO.equipArr.push(patch.readInt());
                        tempLetterVO.equipArr.push(patch.readByte());
                        tempLetterVO.equipArr.push(patch.readInt());
                        tempLetterVO.equipArr.push(patch.readShort());
                        len = patch.readByte();
                        temp_basic = [];
                        ii_index = 0;
                        while(ii_index < len)
                        {
                           temp_basic.push(patch.readByte());
                           temp_basic.push(patch.readInt());
                           temp_basic.push(patch.readInt());
                           ii_index++;
                        }
                        tempLetterVO.equipArr.push(temp_basic);
                        len = patch.readByte();
                        temp_intensify = [];
                        ii_index = 0;
                        while(ii_index < len)
                        {
                           temp_intensify.push(patch.readByte());
                           temp_intensify.push(patch.readInt());
                           ii_index++;
                        }
                        tempLetterVO.equipArr.push(temp_intensify);
                        len = patch.readByte();
                        temp_extra = [];
                        ii_index = 0;
                        while(ii_index < len)
                        {
                           temp_extra.push(patch.readByte());
                           temp_extra.push(patch.readInt());
                           temp_extra.push(patch.readByte());
                           temp_extra.push(patch.readInt());
                           ii_index++;
                        }
                        tempLetterVO.equipArr.push(temp_extra);
                        len = patch.readByte();
                        temp_stoneId = [];
                        ii_index = 0;
                        while(ii_index < len)
                        {
                           temp_stoneId.push(patch.readInt());
                           ii_index++;
                        }
                        tempLetterVO.equipArr.push(temp_stoneId);
                        extra_polish = patch.readUTF();
                        tempLetterVO.equipArr.push(extra_polish);
                        isGrey = patch.readByte();
                        skillId = patch.readInt();
                        skillGrade = patch.readByte();
                        jingLianCount = patch.readByte();
                        tempLetterVO.equipArr.push(isGrey);
                        tempLetterVO.equipArr.push(skillId);
                        tempLetterVO.equipArr.push(skillGrade);
                        tempLetterVO.equipArr.push(jingLianCount);
                        czLen = patch.readByte();
                        temp_jingLian_arr = [];
                        j = 0;
                        while(j < czLen)
                        {
                           temp_jingLian_arr.push(patch.readByte());
                           temp_jingLian_arr.push(patch.readInt());
                           j++;
                        }
                        tempLetterVO.equipArr.push(temp_jingLian_arr);
                        tempLetterVO.equipArr.push(patch.readInt());
                        tempLetterVO.equipArr.push(patch.readByte());
                        tempLetterVO.equipArr.push(patch.readByte());
                        tempLetterVO.equipArr.push(patch.readByte());
                        tempLetterVO.equipArr.push(patch.readByte());
                     }
                  }
               }
               letterVOArr.push(tempLetterVO);
               i++;
            }
            LetterHandler.GC_MAIL(letterVOArr);
         }
      }
      
      public function GC_GET_ATTACHMENT(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         LetterHandler.GC_GET_ATTACHMENT(result);
      }
      
      public function GC_SEND_MAIL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         LetterHandler.GC_SEND_MAIL(result);
      }
   }
}

