package egovframework.com.cmm.util;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

//OBJ -> JSON VO객체에서 사용
public class EgovToStringSerializer extends JsonSerializer<Object> { 

	@Override
	public void serialize(Object value, JsonGenerator jgen, SerializerProvider provider)
			throws java.io.IOException, JsonProcessingException {
		// TODO Auto-generated method stub
		jgen.writeObject(value.toString());
	}

}
