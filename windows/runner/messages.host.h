#include "messages.g.h"

namespace quantum
{

	class QuantumHostApiImpl : public QuantumHostApi
	{
	public:
		QuantumHostApiImpl();
		ErrorOr<std::string> GetHostLanguage() override;
		ErrorOr<int64_t> Add(
			int64_t a,
			int64_t b) override;
		/*void SendMessage(
			const std::string& message,
			std::function<void(ErrorOr<bool> reply)> result) override;*/
		void SendMessageW(
			const std::string& message,
			std::function<void(ErrorOr<bool> reply)> result);
		

		ErrorOr<std::optional<DirectoryResponse>> ChooseDirectory() override;
		ErrorOr<std::optional<std::string>> StartAccessingSecurityScopedResource(const std::string& bookmark_string) override;
	};
}

