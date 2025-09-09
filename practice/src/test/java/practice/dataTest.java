package practice;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class dataTest {

    public static SqlSessionFactory getInstance() {
        String resource = "config/mybatis-config.xml";  // mybatis 설정 파일 경로
        InputStream inputStream = null;
        try {
            inputStream = Resources.getResourceAsStream(resource);
            System.out.println("mybatis-config.xml 로드 성공");
        } catch (IOException e) {
            e.printStackTrace();
        }

        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        return sqlSessionFactory;
    }

    // ✅ 여기서 main 메서드 추가
    public static void main(String[] args) {
        SqlSessionFactory factory = getInstance();
        try (SqlSession session = factory.openSession()) {
            if (session != null) {
                System.out.println("DB 연결 성공! 🎉");
            } else {
                System.out.println("DB 연결 실패...");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
