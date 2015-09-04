package com.chen.entity;

import java.io.Serializable;


public class Business implements Serializable{


	
	private static final long serialVersionUID = 1L;
	
	private Long id; //id generatedKey
	private String bsname; //餐厅名字
	private String bsaddress; //餐厅地址
	private String bsman; //餐厅负责人
	private String bstel; //订餐电话
	private String bscontent; //商家公告
	private String bslat; // 经纬度
	private String bslng;// 经纬度
	private String bscardphoto;
	private String bscardnum;
	private String bscardaddress;
	private String bstype;//例如中餐，西餐。等餐厅分类
	private Long acid; //关联t_account(用户表)得外键
	private Float bspoststartprice;//起送的订餐价格
	private Integer bspostprice; //送货的运费
	private String bsphoto; //商铺的logo
	private String bsamhourstart; //上午开始的营业时间
	private String bsamhourend; //上午结束的营业时间
	private String bspmhourstart; //下午营业的开始时间
	private String bspmhourend; //下午营业的结束时间
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getBsname() {
		return bsname;
	}
	public void setBsname(String bsname) {
		this.bsname = bsname;
	}
	public String getBsaddress() {
		return bsaddress;
	}
	public void setBsaddress(String bsaddress) {
		this.bsaddress = bsaddress;
	}
	public String getBsman() {
		return bsman;
	}
	public void setBsman(String bsman) {
		this.bsman = bsman;
	}
	public String getBstel() {
		return bstel;
	}
	public void setBstel(String bstel) {
		this.bstel = bstel;
	}
	public String getBscontent() {
		return bscontent;
	}
	public void setBscontent(String bscontent) {
		this.bscontent = bscontent;
	}
	public String getBslat() {
		return bslat;
	}
	public void setBslat(String bslat) {
		this.bslat = bslat;
	}
	public String getBslng() {
		return bslng;
	}
	public void setBslng(String bslng) {
		this.bslng = bslng;
	}
	public String getBscardphoto() {
		return bscardphoto;
	}
	public void setBscardphoto(String bscardphoto) {
		this.bscardphoto = bscardphoto;
	}
	public String getBscardnum() {
		return bscardnum;
	}
	public void setBscardnum(String bscardnum) {
		this.bscardnum = bscardnum;
	}
	public String getBscardaddress() {
		return bscardaddress;
	}
	public void setBscardaddress(String bscardaddress) {
		this.bscardaddress = bscardaddress;
	}
	public String getBstype() {
		return bstype;
	}
	public void setBstype(String bstype) {
		this.bstype = bstype;
	}
	public Long getAcid() {
		return acid;
	}
	public void setAcid(Long acid) {
		this.acid = acid;
	}
	public Float getBspoststartprice() {
		return bspoststartprice;
	}
	public void setBspoststartprice(Float bspoststartprice) {
		this.bspoststartprice = bspoststartprice;
	}
	public Integer getBspostprice() {
		return bspostprice;
	}
	public void setBspostprice(Integer bspostprice) {
		this.bspostprice = bspostprice;
	}
	public String getBsphoto() {
		return bsphoto;
	}
	public void setBsphoto(String bsphoto) {
		this.bsphoto = bsphoto;
	}
	public String getBsamhourstart() {
		return bsamhourstart;
	}
	public void setBsamhourstart(String bsamhourstart) {
		this.bsamhourstart = bsamhourstart;
	}
	public String getBsamhourend() {
		return bsamhourend;
	}
	public void setBsamhourend(String bsamhourend) {
		this.bsamhourend = bsamhourend;
	}
	public String getBspmhourstart() {
		return bspmhourstart;
	}
	public void setBspmhourstart(String bspmhourstart) {
		this.bspmhourstart = bspmhourstart;
	}
	public String getBspmhourend() {
		return bspmhourend;
	}
	public void setBspmhourend(String bspmhourend) {
		this.bspmhourend = bspmhourend;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((acid == null) ? 0 : acid.hashCode());
		result = prime * result
				+ ((bsaddress == null) ? 0 : bsaddress.hashCode());
		result = prime * result
				+ ((bsamhourend == null) ? 0 : bsamhourend.hashCode());
		result = prime * result
				+ ((bsamhourstart == null) ? 0 : bsamhourstart.hashCode());
		result = prime * result
				+ ((bscardaddress == null) ? 0 : bscardaddress.hashCode());
		result = prime * result
				+ ((bscardnum == null) ? 0 : bscardnum.hashCode());
		result = prime * result
				+ ((bscardphoto == null) ? 0 : bscardphoto.hashCode());
		result = prime * result
				+ ((bscontent == null) ? 0 : bscontent.hashCode());
		result = prime * result + ((bslat == null) ? 0 : bslat.hashCode());
		result = prime * result + ((bslng == null) ? 0 : bslng.hashCode());
		result = prime * result + ((bsman == null) ? 0 : bsman.hashCode());
		result = prime * result + ((bsname == null) ? 0 : bsname.hashCode());
		result = prime * result + ((bsphoto == null) ? 0 : bsphoto.hashCode());
		result = prime * result
				+ ((bspmhourend == null) ? 0 : bspmhourend.hashCode());
		result = prime * result
				+ ((bspmhourstart == null) ? 0 : bspmhourstart.hashCode());
		result = prime * result
				+ ((bspostprice == null) ? 0 : bspostprice.hashCode());
		result = prime
				* result
				+ ((bspoststartprice == null) ? 0 : bspoststartprice.hashCode());
		result = prime * result + ((bstel == null) ? 0 : bstel.hashCode());
		result = prime * result + ((bstype == null) ? 0 : bstype.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Business other = (Business) obj;
		if (acid == null) {
			if (other.acid != null)
				return false;
		} else if (!acid.equals(other.acid))
			return false;
		if (bsaddress == null) {
			if (other.bsaddress != null)
				return false;
		} else if (!bsaddress.equals(other.bsaddress))
			return false;
		if (bsamhourend == null) {
			if (other.bsamhourend != null)
				return false;
		} else if (!bsamhourend.equals(other.bsamhourend))
			return false;
		if (bsamhourstart == null) {
			if (other.bsamhourstart != null)
				return false;
		} else if (!bsamhourstart.equals(other.bsamhourstart))
			return false;
		if (bscardaddress == null) {
			if (other.bscardaddress != null)
				return false;
		} else if (!bscardaddress.equals(other.bscardaddress))
			return false;
		if (bscardnum == null) {
			if (other.bscardnum != null)
				return false;
		} else if (!bscardnum.equals(other.bscardnum))
			return false;
		if (bscardphoto == null) {
			if (other.bscardphoto != null)
				return false;
		} else if (!bscardphoto.equals(other.bscardphoto))
			return false;
		if (bscontent == null) {
			if (other.bscontent != null)
				return false;
		} else if (!bscontent.equals(other.bscontent))
			return false;
		if (bslat == null) {
			if (other.bslat != null)
				return false;
		} else if (!bslat.equals(other.bslat))
			return false;
		if (bslng == null) {
			if (other.bslng != null)
				return false;
		} else if (!bslng.equals(other.bslng))
			return false;
		if (bsman == null) {
			if (other.bsman != null)
				return false;
		} else if (!bsman.equals(other.bsman))
			return false;
		if (bsname == null) {
			if (other.bsname != null)
				return false;
		} else if (!bsname.equals(other.bsname))
			return false;
		if (bsphoto == null) {
			if (other.bsphoto != null)
				return false;
		} else if (!bsphoto.equals(other.bsphoto))
			return false;
		if (bspmhourend == null) {
			if (other.bspmhourend != null)
				return false;
		} else if (!bspmhourend.equals(other.bspmhourend))
			return false;
		if (bspmhourstart == null) {
			if (other.bspmhourstart != null)
				return false;
		} else if (!bspmhourstart.equals(other.bspmhourstart))
			return false;
		if (bspostprice == null) {
			if (other.bspostprice != null)
				return false;
		} else if (!bspostprice.equals(other.bspostprice))
			return false;
		if (bspoststartprice == null) {
			if (other.bspoststartprice != null)
				return false;
		} else if (!bspoststartprice.equals(other.bspoststartprice))
			return false;
		if (bstel == null) {
			if (other.bstel != null)
				return false;
		} else if (!bstel.equals(other.bstel))
			return false;
		if (bstype == null) {
			if (other.bstype != null)
				return false;
		} else if (!bstype.equals(other.bstype))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

}
