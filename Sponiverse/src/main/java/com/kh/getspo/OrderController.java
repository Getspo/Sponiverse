package com.kh.getspo;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.EventDAO;
import dao.OrderDAO;
import dao.UserDAO;
import util.Common;
import vo.EventVO;
import vo.OrderVO;
import vo.PayVO;
import vo.UserVO;

@Controller
public class OrderController {
	@Autowired
	HttpServletRequest request;
	@Autowired
	HttpSession session;

	@Autowired
	ServletContext app;

	@Autowired
	OrderDAO order_dao;

	@Autowired
	UserDAO user_dao;

	public OrderController(OrderDAO order_dao, UserDAO user_dao) {
		this.order_dao = order_dao;
		this.user_dao = user_dao;
	}

	// 이벤트 신청
	@RequestMapping("/orderevent.do")
	@ResponseBody
	public String orderEventTwo(@RequestParam("event_idx") int eventIdx, OrderVO order) {
		UserVO user = (UserVO) session.getAttribute("user");

		// 사용자가 로그인하지 않은 경우
		if (user == null) {
			return "redirect:/signinform.do?event_idx";
		}
		int userIdx = user.getUser_idx();

		// 이미 신청한 이벤트인지 확인
		boolean alreadyRegistered = order_dao.isAlreadyRegistered(userIdx, eventIdx);
		if (alreadyRegistered) {
			return "already_registered"; // 이미 신청한 이벤트
		}

		order_dao.orderevent(order);

		return "success";

	}

	@RequestMapping(value = "/order.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String orderEvent(OrderVO order) {
		UserVO user = (UserVO) session.getAttribute("user");

		// 사용자가 로그인하지 않은 경우
		if (user == null) {
			return "redirect:/signinform.do";
		}

		int userIdx = user.getUser_idx();
		int eventIdx = order.getEvent_idx();

		// 이미 신청한 이벤트인지 확인
		boolean alreadyRegistered = order_dao.isAlreadyRegistered(userIdx, eventIdx);

		if (alreadyRegistered) {
			return "already_registered"; // 이미 신청한 이벤트
		}

		int res = order_dao.orderevent(order);
		String result = "no";
		if (res > 0) {
			String orderIdx = String.valueOf(order.getOrder_idx());
			result = orderIdx;
		}
		return result;
	}

	@RequestMapping(value = "/payment.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String processPayment(@RequestParam("imp_uid") String impUid,
			@RequestParam("merchant_uid") String merchantUid, @RequestParam("paid_amount") int paidAmount,
			@RequestParam("apply_num") String applyNum, @RequestParam("user_idx") Integer userIdx,
			@RequestParam("order_idx") Integer orderIdx) {

		PayVO pay = new PayVO();
		pay.setImp_uid(impUid);
		pay.setMerchant_uid(merchantUid);
		pay.setPay_price(paidAmount);
		pay.setApply_num(applyNum);
		pay.setUser_idx(userIdx);
		pay.setOrder_idx(orderIdx);

		try {
			order_dao.savePay(pay);
			System.out.println("Payment Processed Successfully"); // 추가된 로그
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Payment Processing Failed: " + e.getMessage()); // 추가된 로그
			return "fail";
		}
	}

	// 마이페이지 참가 리스트 삭제
	@RequestMapping("/cancelEvent.do")
	@ResponseBody
	public String cancelEvent(@RequestParam("user_idx") int user_idx, @RequestParam("event_idx") int event_idx) {

		int res_del = order_dao.cancelEvent(user_idx, event_idx);
		session.removeAttribute("event");
		if (res_del > 0) {
			return "[{'result':'clear'}]";// 삭제 성공
		} else {
			return "[{'result':'fail'}]";// 삭제 실패
		}

	}

}
