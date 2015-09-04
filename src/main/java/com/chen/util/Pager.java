package com.chen.util;

import java.util.List;

public class Pager<T> {

		private Integer pageNo;  //ҳ���
		private Integer pageSize; //��ҳ���С
		private Integer totalSize;//�ܴ�С����
		private Integer totalPages;//��ҳ��
		private Integer start;  //��ѯ��ʼ�����֣��Ǳ�ҳ��ǰ������д�С
		private List<T> items;
		

		public Pager(){}
		
		public Pager(Integer totalSize,Integer pageSize){
			this.totalSize = totalSize;
			this.pageSize = pageSize;
				Integer temp = totalSize / pageSize;
				if(totalSize % pageSize != 0){
					temp++;
			}
				this.totalPages = temp;
		}
		
		public Pager(Integer pageNo, Integer totalSize, Integer pageSize) {
			this(totalSize,pageSize);
			
			if(pageNo < 1) {
				pageNo = 1;
			}
			if(pageNo > totalPages) {
				pageNo = totalPages;
			}
			
			this.pageNo = pageNo;
			if(pageNo == 0) {
				this.start = 0;
			} else {
				this.start = (pageNo - 1) * pageSize;
			}
		}
		
		
		public Integer getPageNo() {
			return pageNo;
		}

		public void setPageNo(Integer pageNo) {
			this.pageNo = pageNo;
		}

		public Integer getPageSize() {
			return pageSize;
		}

		public void setPageSize(Integer pageSize) {
			this.pageSize = pageSize;
		}

		public Integer getTotalSize() {
			return totalSize;
		}

		public void setTotalSize(Integer totalSize) {
			this.totalSize = totalSize;
		}

		public Integer getTotalPages() {
			return totalPages;
		}

		public void setTotalPages(Integer totalPages) {
			this.totalPages = totalPages;
		}

		public Integer getStart() {
			return start;
		}

		public void setStart(Integer start) {
			this.start = start;
		}

		public List<T> getItems() {
			return items;
		}

		public void setItems(List<T> items) {
			this.items = items;
		}

}
