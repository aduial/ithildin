package aduial.ithildin.entity;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;;

import com.j256.ormlite.table.DatabaseTable;

/**
 * Created by luthien on 18/02/2021.
 */
@DatabaseTable(tableName = "CORRECTIONVIEW")
public class CorrectionView implements Root {

  @DatabaseField
  private Integer refidfrom;
  @DatabaseField
  private Integer refidto;
  @DatabaseField
  private String formtxt;
  @DatabaseField
  private String sourcename;
  @DatabaseField
  private String sourceprefix;
  @DatabaseField
  private String sourcestring;
  @DatabaseField
  private String sourcetypetxt;

  protected CorrectionView() {}

  public Integer getRefidfrom() {
    return refidfrom;
  }

  public void setRefidfrom(Integer refidfrom) {
    this.refidfrom = refidfrom;
  }


  public Integer getRefidto() {
    return refidto;
  }

  public void setRefidto(Integer refidto) {
    this.refidto = refidto;
  }


  public String getFormtxt() {
    return formtxt;
  }

  public void setFormtxt(String formtxt) {
    this.formtxt = formtxt;
  }


  public String getSourcename() {
    return sourcename;
  }

  public void setSourcename(String sourcename) {
    this.sourcename = sourcename;
  }


  public String getSourceprefix() {
    return sourceprefix;
  }

  public void setSourceprefix(String sourceprefix) {
    this.sourceprefix = sourceprefix;
  }


  public String getSourcestring() {
    return sourcestring;
  }

  public void setSourcestring(String sourcestring) {
    this.sourcestring = sourcestring;
  }


  public String getSourcetypetxt() {
    return sourcetypetxt;
  }

  public void setSourcetypetxt(String sourcetypetxt) {
    this.sourcetypetxt = sourcetypetxt;
  }

}
