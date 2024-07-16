package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import vo.OrderVO;
import vo.PayVO;

public class OrderDAO {
	@Autowired
	SqlSession sqlSession;

	public OrderDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 유저행사신청
	public int orderevent(OrderVO user) {
		int res = sqlSession.insert("o.user_order", user);
		System.out.println("inser res = " + res);
		System.out.println("order_idx = " + user.getOrder_idx());
		return res;
	}

	// 사용자가 이미 신청한 이벤트인지 확인
	public boolean isAlreadyRegistered(int userIdx, int eventIdx) {
		Map<String, Integer> params = new HashMap<>();
		params.put("user_idx", userIdx);
		params.put("event_idx", eventIdx);
		int count = sqlSession.selectOne("o.isAlreadyRegistered", params);
		return count > 0;
	}

	// 결제
	public int savePay(PayVO pay) {
		return sqlSession.insert("o.user_pay", pay);
	}

	// 사용자가 신청한 행사 리스트
	public List<OrderVO> selectEventByorder(int user_idx) {
		return sqlSession.selectList("o.user_order_list", user_idx);
	}

}
