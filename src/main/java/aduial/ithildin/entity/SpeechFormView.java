package aduial.ithildin.entity;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;;

/**
 * Created by luthien on 18/02/2021.
 */
@DatabaseTable(tableName = "SPEECHFORMVIEW")
public class SpeechFormView implements Root {

  public static final String ENTRYID_FIELD_NAME = "ENTRY_ID";

  @DatabaseField(columnName = ENTRYID_FIELD_NAME)
  private Integer entryId;
  @DatabaseField
  private String txt;

  protected SpeechFormView() {}

  public Integer getEntryId() {
    return entryId;
  }

  public void setEntryId(Integer entryId) {
    this.entryId = entryId;
  }


  public String getTxt() {
    return txt;
  }

  public void setTxt(String txt) {
    this.txt = txt;
  }

}
