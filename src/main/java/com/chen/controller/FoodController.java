package com.chen.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chen.dto.Message;
import com.chen.entity.Business;
import com.chen.entity.Food;
import com.chen.entity.FoodType;
import com.chen.exception.ForbiddenException;
import com.chen.exception.NotFoundException;
import com.chen.service.BusinessService;
import com.chen.service.CommonsService;
import com.chen.service.FoodService;
import com.chen.service.FoodTypeService;
import com.chen.util.Const;
import com.chen.util.Pager;
import com.chen.util.QiniuUtil;
import com.chen.util.ServletUtil;
import com.mysql.jdbc.interceptors.SessionAssociationInterceptor;

@Controller
@RequestMapping("/shangjia/manage")
public class FoodController {

	@Autowired
	private BusinessService businessService;
	
	@Autowired
	private CommonsService commonsService;
	
	@Autowired
	private FoodTypeService foodTypeService;
	
	@Autowired
	private FoodService foodService;
	@Autowired
	private QiniuUtil qiniuUtil;
	
	/**
	 * get请求，进入显示foodtypes的页面
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/foodtypes",method = RequestMethod.GET)
    public String foodTypeList(Model model, HttpSession session) {
        Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
        if(business == null){
        	return "redirect:/shangjia/login";
        }
        List<FoodType> foodTypes = foodTypeService.findAllFoodTypeByBusinessId(business.getId());
        model.addAttribute("foodTypes",foodTypes);
        return "shangjia/foodtypes";
    }
	
	/**
	 * get请求，请求转发到foodtype的添加页面
	 * @return
	 */
	@RequestMapping(value = "/foodtypes/new", method = RequestMethod.GET)
	public String saveFoodType(){
		return "shangjia/foodtypes-new";
	}
	
	@RequestMapping(value = "/foodtypes/new", method = RequestMethod.POST)
	public String saveFoodType(FoodType foodType, HttpSession session, RedirectAttributes redirectAttributes){
		Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		foodType.setBsid(business.getId());
		foodTypeService.saveFoodType(foodType);
		redirectAttributes.addAttribute("message", "添加餐品类型成功");
		return "redirect:/shangjia/manage/foodtypes";
	}
	
	@RequestMapping(value = "/foodtypes/edit/{id:\\d++}", method = RequestMethod.GET)
	public String editFoodType(@PathVariable("id") Long typeid,Model model, HttpSession session){
		Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		FoodType foodType = foodTypeService.findFoodTypeById(typeid);
		if(foodType == null){
			throw new NotFoundException();
		}
		if(foodType.getBsid().equals(business.getId())){
			model.addAttribute("foodType", foodType);
			return "shangjia/foodtypes-edit";
		}else{
			throw new ForbiddenException();
		}
	}
	
	@RequestMapping(value = "/foodtypes/edit/{id:\\d++}", method = RequestMethod.POST)
	public String editFoodType(FoodType foodType, HttpSession session, RedirectAttributes redirectAttributes){
		Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		foodType.setBsid(business.getId());
		foodTypeService.editFoodType(foodType);
		redirectAttributes.addFlashAttribute("message", "修改餐品成功");
		return "redirect:/shangjia/manage/foodtypes";
	}
	/**
	 * 根据id删除
	 * @param typeid
	 * @param session
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/foodtypes/del/{id:\\d++}", method = RequestMethod.GET)
	public String delFoodType(@PathVariable("id") Long typeid, HttpSession session,
			RedirectAttributes redirectAttributes){
		Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		if(typeid < 0){
			throw new NotFoundException();
		}
		FoodType foodType = foodTypeService.findFoodTypeById(typeid);
		if(foodType == null ){
			throw new NotFoundException();
		}
		if(foodType.getBsid().equals(business.getId())){
			foodTypeService.delFoodTypeById(typeid);
			return "shangjia/foodtypes";
		}else{
			throw new ForbiddenException();
		}
	}
	
	/**
	 * 分页查找Food的列表
	 * @param model
	 * @param session
	 * @param request
	 * @param p
	 * @return
	 */
	@RequestMapping(value = "/foods",method = RequestMethod.GET)
    public String foodList(Model model,HttpSession session,
    		HttpServletRequest request,
    		@RequestParam(required = false, defaultValue = "1") int p) {
        Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
        if(business == null){
        	return "redirect:/shangjia/login";
        }
        Map<String, Object> params = ServletUtil.builderParam(request);
        params.put("bsid", business.getId());
        Pager<Food> page = foodService.findFoodByPager(p, params);
        model.addAttribute("page",page);
        return "shangjia/foods";
    } 
	
	@RequestMapping(value = "/foods/new", method = RequestMethod.GET)
	public String saveNewFood(Model model, HttpSession session){
		Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		
		List<FoodType> foodTypes = foodTypeService.findAllFoodTypeByBusinessId(business.getId());
		String token = qiniuUtil.getToken();
		model.addAttribute("token", token);
		model.addAttribute("foodTypes", foodTypes);
		return "shangjia/foods-new";
	}
	/**
	 * 
	 * @param model
	 * @param session
	 * @param food
	 * @param photo
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/foods/new",method = RequestMethod.POST)
    public String saveNewFood(Model model,HttpSession session,Food food,RedirectAttributes redirectAttributes) {
        Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
        foodService.saveFood(business,food);
        redirectAttributes.addFlashAttribute("message","添加成功");
        return "redirect:/shangjia/manage/foods";
    }
	
	
	/**
     * 删除餐品
     */
    @RequestMapping(value = "/foods/del/{id:\\d+}",method = RequestMethod.GET)
    public Message del(@PathVariable(value = "id") Long id,HttpSession session) {
        Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);

        Food food = foodService.findFoodById(id);
        
        if(food == null) {
            throw new NotFoundException();
        }
        if(food.getBsid() != business.getId()) {
            throw new ForbiddenException();
        }
        foodService.delFood(id);
        //redirectAttributes.addFlashAttribute("message", "删除成功");
        //return "redirect:/shangjia/manage/foods";
        return new Message("success", "删除成功");
    }
	
    /**
     * 编辑餐品
     */
    @RequestMapping(value = "/foods/edit/{id:\\d+}",method = RequestMethod.GET)
    public String editFood(@PathVariable Long id,HttpSession session,Model model) {
        Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);

        Food food = foodService.findFoodById(id);
        if(food == null) {
            throw new NotFoundException();
        }
        if(!food.getBsid().equals(business.getId())) {
            throw new ForbiddenException();
        }
        String token = qiniuUtil.getToken();
        model.addAttribute("token", token);
        model.addAttribute("food",food);
        model.addAttribute("foodTypes",foodTypeService.findAllFoodTypeByBusinessId(business.getId()));
        return "shangjia/foods-edit";
    }

    @RequestMapping(value = "/foods/edit/{id:\\d+}",method = RequestMethod.POST)
    public String editFood(Food food, HttpSession session,RedirectAttributes redirectAttributes) {
        foodService.editFood(food);
        redirectAttributes.addFlashAttribute("message", "修改成功");
        return "redirect:/shangjia/manage/foods";
    }
    
    /**
     * 通过**查询餐品
     * @param model
     * @param request
     * @param session
     * @param p
     * */
    @RequestMapping(value = "/foods/states", method = RequestMethod.GET)
    @ResponseBody
    public Message editStates(Integer id, Boolean fsales){
    	if(id < 0){
    		return new Message("error", "传入参数错误");
    	}
    	if(foodService.editIsSales(fsales, id)>0){
    		return new Message("success",id);
    	}else{
    		return new Message("error","服务器忙，请重试");
    	}
    }
}
